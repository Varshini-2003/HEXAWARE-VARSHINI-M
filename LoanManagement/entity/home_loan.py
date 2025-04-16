from entity.loan import Loan

class HomeLoan(Loan):
    def __init__(self, loan_id=None, customer=None, principal_amount=0.0, interest_rate=0.0,
                 loan_term=0, loan_type='HomeLoan', loan_status='Pending',
                 property_address=None, property_value=0):
        super().__init__(loan_id, customer, principal_amount, interest_rate, loan_term, loan_type, loan_status)
        self.property_address = property_address
        self.property_value = property_value

    def __str__(self):
        base = super().__str__()
        return f"{base}, Property Address={self.property_address}, Property Value={self.property_value}"
