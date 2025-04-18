import unittest

# Sample Payroll Calculation Functions
def calculate_gross_salary(basic, hra, allowances):
    return basic + hra + allowances

def calculate_net_salary(gross_salary, tax, insurance):
    return gross_salary - (tax + insurance)

def calculate_tax(income):
    if income > 100000:
        return income * 0.2  
    else:
        return income * 0.1
def process_payroll(employees):
    return [calculate_net_salary(e['gross'], e['tax'], e['insurance']) for e in employees]

def validate_employee_data(employee):
    if not employee.get('name') or employee.get('gross') < 0:
        raise ValueError("Invalid Employee Data")

# Unit Test Cases
class TestPayrollSystem(unittest.TestCase):

    def test_calculate_gross_salary(self):
        self.assertEqual(calculate_gross_salary(30000, 10000, 5000), 45000)

    def test_calculate_net_salary_after_deductions(self):
        self.assertEqual(calculate_net_salary(50000, 8000, 2000), 40000)

    def test_verify_tax_calculation_for_high_income_employee(self):
        self.assertEqual(calculate_tax(150000), 30000)  

    def test_process_payroll_for_multiple_employees(self):
        employees = [
            {'gross': 60000, 'tax': 10000, 'insurance': 2000},
            {'gross': 50000, 'tax': 8000, 'insurance': 1000}
        ]
        result = process_payroll(employees)
        self.assertEqual(result, [48000, 41000])

    def test_verify_error_handling_for_invalid_employee_data(self):
        with self.assertRaises(ValueError):
            validate_employee_data({'name': '', 'gross': 50000})

        with self.assertRaises(ValueError):
            validate_employee_data({'name': 'John', 'gross': -10000})

# Run Tests
if __name__ == '__main__':
    unittest.main()