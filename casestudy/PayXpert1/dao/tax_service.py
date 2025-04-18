from dao.i_tax_service import ITaxService
from util.dbconnutil import DBConnUtil
from exception.tax_calculation_exception import TaxCalculationException

class TaxService(ITaxService):

    def calculate_tax(self, employee_id, tax_year):
        # Placeholder for future implementation
        raise TaxCalculationException("Tax calculation not implemented yet.")

    def get_tax_by_id(self, tax_id):
        conn = DBConnUtil.get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM Tax WHERE TaxID=?", (tax_id,))
        row = cursor.fetchone()
        if row:
            return list(row)
        raise TaxCalculationException(f"Tax with ID {tax_id} not found.")
    
    def get_taxes_for_employee(self, employee_id):
        conn = DBConnUtil.get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM Tax WHERE EmployeeID=?", (employee_id,))
        rows = cursor.fetchall()
        return [list(row) for row in rows]

    def get_taxes_for_year(self, tax_year):
        conn = DBConnUtil.get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM Tax WHERE TaxYear=?", (tax_year,))
        rows = cursor.fetchall()
        return [list(row) for row in rows]

    def get_taxes_grouped_by_year(self, employee_id):
        conn = DBConnUtil.get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM Tax WHERE EmployeeID=?", (employee_id,))
        rows = cursor.fetchall()
        grouped = {}
        for row in rows:
            year = row[2]
            tax_info = [row[0], row[3], row[4]]  # TaxID, TaxableIncome, TaxAmount
            if year not in grouped:
                grouped[year] = []
            grouped[year].append(tax_info)
        return grouped
