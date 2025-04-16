class InvalidLoanException(Exception):
    def __init__(self, message="Invalid Loan ID provided. Loan not found in the database."):
        self.message = message
        super().__init__(self.message)

