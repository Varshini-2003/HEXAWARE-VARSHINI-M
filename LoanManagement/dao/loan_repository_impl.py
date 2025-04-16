import pyodbc
from dao.iloan_repository import ILoanRepository
from entity.customer import Customer
from entity.loan import Loan
from entity.home_loan import HomeLoan
from entity.car_loan import CarLoan
from exception.invalid_loan_exception import InvalidLoanException
from util.util import DBConnUtil

class LoanRepositoryImpl(ILoanRepository):

    def __init__(self):
        self.conn = DBConnUtil.get_connection()
        self.cursor = self.conn.cursor()

    def apply_loan(self, loan):
        confirm = input("Do you want to proceed with the loan application? (Yes/No): ")
        if confirm.lower() != 'yes':
            print("Loan application cancelled.")
            return

        try:
            self.cursor.execute("""
                INSERT INTO Loan (loanId, customerId, principalAmount, interestRate, loanTerm, loanType, loanStatus)
                VALUES (?, ?, ?, ?, ?, ?, ?)""",
                loan.loan_id, loan.customer.customer_id, loan.principal_amount,
                loan.interest_rate, loan.loan_term, loan.loan_type, loan.loan_status)

            if isinstance(loan, HomeLoan):
                self.cursor.execute("""
                    INSERT INTO HomeLoan (loanId, propertyAddress, propertyValue)
                    VALUES (?, ?, ?)""",
                    loan.loan_id, loan.property_address, loan.property_value)

            elif isinstance(loan, CarLoan):
                self.cursor.execute("""
                    INSERT INTO CarLoan (loanId, carModel, carValue)
                    VALUES (?, ?, ?)""",
                    loan.loan_id, loan.car_model, loan.car_value)

            self.conn.commit()
            print("Loan successfully applied.")
        except Exception as e:
            print(f"Error applying loan: {e}")

    def calculate_interest(self, loan_id):
        loan = self.get_loan_by_id(loan_id)
        if loan:
            return self.calculate_interest_by_params(loan.principal_amount, loan.interest_rate, loan.loan_term)
        else:
            raise InvalidLoanException()

    def calculate_interest_by_params(self, principal_amount, interest_rate, loan_term):
        return (principal_amount * interest_rate * loan_term) / (12 * 100)

    def loan_status(self, loan_id):
        loan = self.get_loan_by_id(loan_id)
        if loan:
            credit_score = loan.customer.credit_score
            new_status = 'Approved' if credit_score > 650 else 'Rejected'
            self.cursor.execute("UPDATE Loan SET loanStatus = ? WHERE loanId = ?", new_status, loan_id)
            self.conn.commit()
            print(f"Loan Status updated to {new_status}")
        else:
            raise InvalidLoanException()

    def calculate_emi(self, loan_id):
        loan = self.get_loan_by_id(loan_id)
        if loan:
            return self.calculate_emi_by_params(loan.principal_amount, loan.interest_rate, loan.loan_term)
        else:
            raise InvalidLoanException()

    def calculate_emi_by_params(self, principal_amount, interest_rate, loan_term):
        r = interest_rate / (12 * 100)
        emi = (principal_amount * r * pow(1 + r, loan_term)) / (pow(1 + r, loan_term) - 1)
        return round(emi, 2)

    def loan_repayment(self, loan_id, amount):
        emi = self.calculate_emi(loan_id)
        emi=float(emi)
        if amount < emi:
            print("Payment amount is less than one EMI. Payment rejected.")
        else:
            num_emis = int(amount // emi)
            print(f"Payment successful. You have paid {num_emis} EMIs.")

    def get_all_loans(self):
        self.cursor.execute("SELECT * FROM Loan")
        rows = self.cursor.fetchall()
        loan_list = []
        for row in rows:
            loan_list.append(row)
        return loan_list


    def get_loan_by_id(self, loan_id):
        self.cursor.execute("SELECT * FROM Loan WHERE loanId = ?", loan_id)
        row = self.cursor.fetchone()
        if row:
            customer = self._get_customer_by_id(row.customerId)
            if row.loanType == 'HomeLoan':
                self.cursor.execute("SELECT * FROM HomeLoan WHERE loanId = ?", loan_id)
                hrow = self.cursor.fetchone()
                return HomeLoan(row.loanId, customer, row.principalAmount, row.interestRate, row.loanTerm,
                                row.loanType, row.loanStatus, hrow.propertyAddress, hrow.propertyValue)
            elif row.loanType == 'CarLoan':
                self.cursor.execute("SELECT * FROM CarLoan WHERE loanId = ?", loan_id)
                crow = self.cursor.fetchone()
                return CarLoan(row.loanId, customer, row.principalAmount, row.interestRate, row.loanTerm,
                               row.loanType, row.loanStatus, crow.carModel, crow.carValue)
            else:
                return Loan(row.loanId, customer, row.principalAmount, row.interestRate,
                            row.loanTerm, row.loanType, row.loanStatus)
        else:
            return None

    def _get_customer_by_id(self, customer_id):
        self.cursor.execute("SELECT * FROM Customer WHERE customerId = ?", customer_id)
        row = self.cursor.fetchone()
        return Customer(row.customerId, row.name, row.emailAddress, row.phoneNumber, row.address, row.creditScore)
