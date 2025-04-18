class FinancialRecord:
    def __init__(self, record_id, employee_id, record_date, description, amount, record_type):
        self.record_id = record_id
        self.employee_id = employee_id
        self.record_date = record_date
        self.description = description
        self.amount = amount
        self.record_type = record_type

    def __str__(self):
        return f"FinancialRecord({self.record_id}, {self.record_type}, Amount={self.amount})"
