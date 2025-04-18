from dao.employee_service import EmployeeService
from dao.payroll_service import PayrollService
from dao.tax_service import TaxService
from dao.financial_record_service import FinancialRecordService
from entity.employee import Employee
from entity.payroll import Payroll
from entity.tax import Tax
from entity.financial_record import FinancialRecord
from exception.employee_not_found_exception import EmployeeNotFoundException
from exception.payroll_generation_exception import PayrollGenerationException
from exception.tax_calculation_exception import TaxCalculationException
from exception.financial_record_exception import FinancialRecordException
from exception.invalid_input_exception import InvalidInputException
from exception.database_connection_exception import DatabaseConnectionException


def employee_menu():
    dao = EmployeeService()
    while True:
        print("\n--- Employee Menu ---")
        print("1. Add Employee")
        print("2. Get Employee by ID")
        print("3. List All Employees")
        print("4. Update Employee")
        print("5. Remove Employee")
        print("6. Back to Main Menu")
        try:
            choice = int(input("Enter your choice: "))
            if choice == 1:
                emp = Employee(
                    None,
                    input("First Name: "),
                    input("Last Name: "),
                    input("Date of Birth (YYYY-MM-DD): "),
                    input("Gender: "),
                    input("Email: "),
                    input("Phone Number: "),
                    input("Address: "),
                    input("Position: "),
                    input("Joining Date (YYYY-MM-DD): "),
                    input("Termination Date (or press Enter for None): ") or None
                )
                dao.add_employee(emp)
                print("Employee added successfully.")
            elif choice == 2:
                emp_id = int(input("Employee ID: "))
                emp = dao.get_employee_by_id(emp_id)
                for field, value in vars(emp).items():
                    print(f"{field}: {value}")
            elif choice == 3:
                emps = dao.get_all_employees()
                for emp in emps:
                    for field, value in vars(emp).items():
                        print(f"{field}: {value}")
                    print("-" * 40)
            elif choice == 4:
                emp_id = int(input("Employee ID to update: "))
                emp = dao.get_employee_by_id(emp_id)
                emp.first_name = input("First Name: ")
                emp.last_name = input("Last Name: ")
                emp.dob = input("Date of Birth (YYYY-MM-DD): ")
                emp.gender = input("Gender: ")
                emp.email = input("Email: ")
                emp.phone = input("Phone: ")
                emp.address = input("Address: ")
                emp.position = input("Position: ")
                emp.joining_date = input("Joining Date (YYYY-MM-DD): ")
                emp.termination_date = input("Termination Date (or press Enter for None): ") or None
                dao.update_employee(emp)
                print("Employee updated.")
            elif choice == 5:
                emp_id = int(input("Employee ID to delete: "))
                dao.remove_employee(emp_id)
                print("Employee removed.")
            elif choice == 6:
                break
        except Exception as e:
            print("Error:", e)


def payroll_menu():
    dao = PayrollService()
    while True:
        print("\n--- Payroll Menu ---")
        print("1. Get Payroll by ID")
        print("2. Get Payrolls for Employee")
        print("3. Get Payrolls for Period")
        print("4. Back to Main Menu")
        try:
            choice = int(input("Enter your choice: "))
            if choice == 1:
                pid = int(input("Payroll ID: "))
                payroll = dao.get_payroll_by_id(pid)
                for field, value in vars(payroll).items():
                    print(f"{field}: {value}")
            elif choice == 2:
                eid = int(input("Employee ID: "))
                pr_list = dao.get_payrolls_for_employee(eid)
                for pr in pr_list:
                    for field, value in vars(pr).items():
                        print(f"{field}: {value}")
                    print("-" * 40)
            elif choice == 3:
                start = input("Start Date (YYYY-MM-DD): ")
                end = input("End Date (YYYY-MM-DD): ")
                pr_list = dao.get_payrolls_for_period(start, end)
                for pr in pr_list:
                    for field, value in vars(pr).items():
                        print(f"{field}: {value}")
                    print("-" * 40)
            elif choice == 4:
                break
        except Exception as e:
            print("Error:", e)


def tax_menu():
    dao = TaxService()
    while True:
        print("\n--- Tax Menu ---")
        print("1. Get Tax by ID")
        print("2. Get Taxes for Employee")
        print("3. Get Taxes for Year")
        print("4. Back to Main Menu")
        try:
            choice = int(input("Enter your choice: "))
            if choice == 1:
                tid = int(input("Tax ID: "))
                tax = dao.get_tax_by_id(tid)
                print(tax)
            elif choice == 2:
                eid = int(input("Employee ID: "))
                taxes = dao.get_taxes_for_employee(eid)
                for t in taxes:
                    print(t)
            elif choice == 3:
                year = int(input("Tax Year: "))
                taxes = dao.get_taxes_for_year(year)
                for t in taxes:
                    print(t)
            elif choice == 4:
                break
        except Exception as e:
            print("Error:", e)


def financial_record_menu():
    dao = FinancialRecordService()
    while True:
        print("\n--- Financial Record Menu ---")
        print("1. Get Record by ID")
        print("2. Get Records for Employee")
        print("3. Get Records for Date")
        print("4. Back to Main Menu")
        try:
            choice = int(input("Enter your choice: "))
            if choice == 1:
                rid = int(input("Record ID: "))
                rec = dao.get_financial_record_by_id(rid)
                print(rec)
            elif choice == 2:
                eid = int(input("Employee ID: "))
                recs = dao.get_financial_records_for_employee(eid)
                for r in recs:
                    print(r)
            elif choice == 3:
                date = input("Date (YYYY-MM-DD): ")
                recs = dao.get_financial_records_for_date(date)
                for r in recs:
                    print(r)
            elif choice == 4:
                break
        except Exception as e:
            print("Error:", e)


def main():
    while True:
        print("\n=== PayXpert Payroll System ===")
        print("1. Employee Management")
        print("2. Payroll Processing")
        print("3. Tax Calculation")
        print("4. Financial Records")
        print("5. Exit")
        try:
            choice = int(input("Select an option: "))
            if choice == 1:
                employee_menu()
            elif choice == 2:
                payroll_menu()
            elif choice == 3:
                tax_menu()
            elif choice == 4:
                financial_record_menu()
            elif choice == 5:
                print("Exiting PayXpert. Goodbye!")
                break
            else:
                print("Invalid option.")
        except Exception as e:
            print("Unexpected error:", e)


if __name__ == "__main__":
    main()
