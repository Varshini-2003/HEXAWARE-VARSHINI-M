class TaxCalculationException(Exception):
    def __init__(self, message="Error calculating tax"):
        super().__init__(message)
