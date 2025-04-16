from entity.loan import Loan

class CarLoan(Loan):
    def __init__(self, loan_id=None, customer=None, principal_amount=0.0, interest_rate=0.0,
                 loan_term=0, loan_type='CarLoan', loan_status='Pending',
                 car_model=None, car_value=0):
        super().__init__(loan_id, customer, principal_amount, interest_rate, loan_term, loan_type, loan_status)
        self.car_model = car_model
        self.car_value = car_value

    def __str__(self):
        base = super().__str__()
        return f"{base}, Car Model={self.car_model}, Car Value={self.car_value}"
