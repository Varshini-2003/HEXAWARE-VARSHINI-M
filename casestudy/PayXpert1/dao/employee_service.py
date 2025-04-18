from dao.i_employee_service import IEmployeeService
from util.dbconnutil import DBConnUtil
from entity.employee import Employee
from exception.employee_not_found_exception import EmployeeNotFoundException

class EmployeeService(IEmployeeService):
    
    def get_employee_by_id(self, employee_id):
        conn = DBConnUtil.get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM Employee WHERE EmployeeID=?", (employee_id,))
        row = cursor.fetchone()
        if not row:
            raise EmployeeNotFoundException(f"Employee with ID {employee_id} not found.")
        return Employee(*row)
    
    def get_all_employees(self):
        conn = DBConnUtil.get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM Employee")
        rows = cursor.fetchall()
        return [Employee(*row) for row in rows]
    
    def add_employee(self, employee):
        conn = DBConnUtil.get_connection()
        cursor = conn.cursor()
        cursor.execute("""
            INSERT INTO Employee (FirstName, LastName, DateOfBirth, Gender, Email, PhoneNumber, Address, Position, JoiningDate, TerminationDate)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """, (employee.first_name, employee.last_name, employee.dob, employee.gender,
              employee.email, employee.phone, employee.address, employee.position,
              employee.joining_date, employee.termination_date))
        conn.commit()
    
    def update_employee(self, employee):
        conn = DBConnUtil.get_connection()
        cursor = conn.cursor()
        cursor.execute("""
            UPDATE Employee SET FirstName=?, LastName=?, DateOfBirth=?, Gender=?, Email=?, PhoneNumber=?, Address=?, Position=?, JoiningDate=?, TerminationDate=?
            WHERE EmployeeID=?
        """, (employee.first_name, employee.last_name, employee.dob, employee.gender,
              employee.email, employee.phone, employee.address, employee.position,
              employee.joining_date, employee.termination_date, employee.employee_id))
        conn.commit()
    
    def remove_employee(self, employee_id):
        conn = DBConnUtil.get_connection()
        cursor = conn.cursor()
        cursor.execute("DELETE FROM Employee WHERE EmployeeID=?", (employee_id,))
        if cursor.rowcount == 0:
            raise EmployeeNotFoundException(f"Employee with ID {employee_id} not found.")
        conn.commit()
