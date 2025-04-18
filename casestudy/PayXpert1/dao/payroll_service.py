from dao.i_payroll_service import IPayrollService
from util.dbconnutil import DBConnUtil
from entity.payroll import Payroll
from exception.payroll_generation_exception import PayrollGenerationException

class PayrollService(IPayrollService):
    
    def generate_payroll(self, employee_id, start_date, end_date):
        raise PayrollGenerationException("Payroll generation not implemented yet.")

    def get_payroll_by_id(self, payroll_id):
        conn = DBConnUtil.get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM Payroll WHERE PayrollID=?", (payroll_id,))
        row = cursor.fetchone()
        if row:
            return Payroll(*row)
        raise PayrollGenerationException(f"Payroll with ID {payroll_id} not found.")
    
    def get_payrolls_for_employee(self, employee_id):
        conn = DBConnUtil.get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM Payroll WHERE EmployeeID=?", (employee_id,))
        rows = cursor.fetchall()
        return [Payroll(*row) for row in rows]
    
    def get_payrolls_for_period(self, start_date, end_date):
        conn = DBConnUtil.get_connection()
        cursor = conn.cursor()
        cursor.execute("""
            SELECT * FROM Payroll WHERE PayPeriodStartDate >= ? AND PayPeriodEndDate <= ?
        """, (start_date, end_date))
        rows = cursor.fetchall()
        return [Payroll(*row) for row in rows]
