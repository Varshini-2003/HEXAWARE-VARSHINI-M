from dao.loan_repository_impl import LoanRepositoryImpl
from entity.customer import Customer
from entity.home_loan import HomeLoan
from entity.car_loan import CarLoan


def main():
    repo = LoanRepositoryImpl()


    while True:
        print("\n==== Loan Management System ====")
        print("1. Apply Loan")
        print("2. View Loan by ID")
        print("3. View All Loans")
        print("4. Loan Repayment")
        print("5. Exit")
        choice = input("Enter your choice: ")

        if choice == '1':
            loan_type = input("Enter loan type (HomeLoan/CarLoan): ")

            # Basic customer info
            customer_id = int(input("Customer ID: "))
            name = input("Name: ")
            email = input("Email: ")
            phone = input("Phone: ")
            address = input("Address: ")
            credit_score = int(input("Credit Score: "))
            customer = Customer(customer_id, name, email, phone, address, credit_score)

            # Common loan info
            loan_id = int(input("Loan ID: "))
            principal = float(input("Principal Amount: "))
            rate = float(input("Interest Rate: "))
            term = int(input("Loan Term (months): "))
            status = "Pending"

            if loan_type == "HomeLoan":
                property_address = input("Property Address: ")
                property_value = int(input("Property Value: "))
                loan = HomeLoan(loan_id, customer, principal, rate, term, status, property_address, property_value)
            elif loan_type == "CarLoan":
                car_model = input("Car Model: ")
                car_value = int(input("Car Value: "))
                loan = CarLoan(loan_id, customer, principal, rate, term, status, car_model, car_value)
            else:
                print("Invalid loan type.")
                continue

            confirm = input("Do you want to proceed? (Yes/No): ").strip().lower()
            if confirm == 'yes':
                repo.apply_loan(loan)
                print(f"Loan application for {loan_type} with Loan ID {loan_id} has been submitted.")
            else:
                print("Loan application cancelled.")

        elif choice == '2':
            loan_id = int(input("Enter Loan ID: "))
            loan = repo.get_loan_by_id(loan_id)
            if loan:
                print(f"Loan Details: {loan}")
            else:
                print(f"No loan found with Loan ID {loan_id}.")

        elif choice == '3':
            loans = repo.get_all_loans()
            print(f"Total loans fetched = {len(loans)}")
            if loans:
                print("\nAll Loans:")
                for loan in loans:
                    print(loan)
            else:
                print("No loans found.")

        elif choice == '4':
            loan_id = int(input("Enter Loan ID: "))
            amount = float(input("Enter Repayment Amount: "))
            repo.loan_repayment(loan_id, amount)
            print(f"Repayment of {amount} for Loan ID {loan_id} has been processed.")

        elif choice == '5':
            print("Exiting...")
            break

        else:
            print("Invalid choice. Try again.")

if __name__ == "__main__":
    main()
