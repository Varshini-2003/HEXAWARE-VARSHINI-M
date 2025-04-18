class FinancialRecordException(Exception):
    def __init__(self, message="Error managing financial record"):
        super().__init__(message)
