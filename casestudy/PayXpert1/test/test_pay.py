import pytest
from util.payroll_utils import (
    calculate_gross_salary,
    calculate_net_salary,
    calculate_tax,
    process_payroll,
    process_employee_data
)

def test_calculate_gross_salary_for_employee():
    
    employee = {
        'base_salary': 5000,
        'bonus': 1000,
        'overtime': 200
    }
    
    expected_gross_salary = 5000 + 1000 + 200
    gross_salary = calculate_gross_salary(employee)  
    assert gross_salary == expected_gross_salary, f"Expected {expected_gross_salary}, but got {gross_salary}"


def test_calculate_net_salary_after_deductions():
   
    employee = {
        'gross_salary': 6000,
        'tax_deduction': 1000,
        'insurance_deduction': 500
    }
    
    expected_net_salary = 6000 - 1000 - 500
    net_salary = calculate_net_salary(employee)  
    assert net_salary == expected_net_salary, f"Expected {expected_net_salary}, but got {net_salary}"


def test_verify_tax_calculation_for_high_income_employee():
    
    employee = {
        'gross_salary': 20000
    }
    
    expected_tax = 6000  
    tax = calculate_tax(employee)
    assert tax == expected_tax, f"Expected {expected_tax}, but got {tax}"


def test_process_payroll_for_multiple_employees():
    
    employees = [
        {'employee_id': 1, 'gross_salary': 5000, 'tax_deduction': 100, 'insurance_deduction': 200},
        {'employee_id': 2, 'gross_salary': 7000, 'tax_deduction': 200, 'insurance_deduction': 300}
    ]
    
    expected_results = [
        {'employee_id': 1, 'net_salary': 5000 - 100 - 200},
        {'employee_id': 2, 'net_salary': 7000 - 200 - 300}
    ]
    
    results = process_payroll(employees)  
    assert results == expected_results, f"Expected {expected_results}, but got {results}"


def test_verify_error_handling_for_invalid_employee_data():
    
    invalid_employee = {'employee_id': 1, 'gross_salary': 5000}  
    
    try:
        process_employee_data(invalid_employee)  # Assuming the function processes employee data
        assert False, "Expected an error due to invalid data, but no error was raised"
    except ValueError as e:
        assert str(e) == "Missing required fields: tax_deduction, insurance_deduction", f"Unexpected error message: {e}"


'''def calculate_gross_salary(employee):
    return employee['base_salary'] + employee['bonus'] + employee['overtime']

def calculate_net_salary(employee):
    return employee['gross_salary'] - employee['tax_deduction'] - employee['insurance_deduction']

def calculate_tax(employee):
    
    if employee['gross_salary'] > 10000:
        return employee['gross_salary'] * 0.3  
    else:
        return employee['gross_salary'] * 0.2  

def process_payroll(employees):
    results = []
    for employee in employees:
        net_salary = employee['gross_salary'] - employee['tax_deduction'] - employee['insurance_deduction']
        results.append({'employee_id': employee['employee_id'], 'net_salary': net_salary})
    return results

def process_employee_data(employee):
    required_fields = ['tax_deduction', 'insurance_deduction']
    for field in required_fields:
        if field not in employee:
            raise ValueError(f"Missing required fields: {', '.join(required_fields)}")
    return True  '''
