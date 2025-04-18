def calculate_gross_salary(employee):
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
    return True  
