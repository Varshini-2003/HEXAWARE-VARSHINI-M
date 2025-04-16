from entity.customer import Customer

class Loan:
    def __init__(self, loan_id=None, customer=None, principal_amount=0.0, interest_rate=0.0, loan_term=0, loan_type=None, loan_status="Pending"):
        self.loan_id = loan_id
        self.customer = customer  # Instance of Customer
        self.principal_amount = principal_amount
        self.interest_rate = interest_rate
        self.loan_term = loan_term
        self.loan_type = loan_type
        self.loan_status = loan_status

    def __str__(self):
        return (f"Loan[ID={self.loan_id}, CustomerID={self.customer.customer_id if self.customer else 'N/A'}, "
                f"Amount={self.principal_amount}, Rate={self.interest_rate}%, Term={self.loan_term} months, "
                f"Type={self.loan_type}, Status={self.loan_status}]")
