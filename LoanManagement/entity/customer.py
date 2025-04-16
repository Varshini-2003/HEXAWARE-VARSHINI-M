class Customer:
    def __init__(self, customer_id=None, name=None, email_address=None, phone_number=None, address=None, credit_score=None):
        self.customer_id = customer_id
        self.name = name
        self.email_address = email_address
        self.phone_number = phone_number
        self.address = address
        self.credit_score = credit_score

    def __str__(self):
        return f"Customer[ID={self.customer_id}, Name={self.name}, Email={self.email_address}, Phone={self.phone_number}, Address={self.address}, Credit Score={self.credit_score}]"
