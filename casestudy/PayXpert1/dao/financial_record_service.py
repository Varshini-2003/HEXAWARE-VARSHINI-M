from dao.i_financial_record_service import IFinancialRecordService
from util.dbconnutil import DBConnUtil
from exception.financial_record_exception import FinancialRecordException

class FinancialRecordService(IFinancialRecordService):

    def add_financial_record(self, record):
        conn = DBConnUtil.get_connection()
        cursor = conn.cursor()
        cursor.execute("""
            INSERT INTO FinancialRecord (EmployeeID, RecordDate, Description, Amount, RecordType)
            VALUES (?, ?, ?, ?, ?)
        """, (
            record.employee_id,
            record.record_date,
            record.description,
            record.amount,
            record.record_type
        ))
        conn.commit()

    def get_financial_record_by_id(self, record_id):
        conn = DBConnUtil.get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM FinancialRecord WHERE RecordID=?", (record_id,))
        row = cursor.fetchone()
        if row:
            return {
                "RecordID": row[0],
                "EmployeeID": row[1],
                "RecordDate": row[2],
                "Description": row[3],
                "Amount": row[4],
                "RecordType": row[5]
            }
        raise FinancialRecordException(f"Record with ID {record_id} not found.")
    
    def get_financial_records_for_employee(self, employee_id):
        conn = DBConnUtil.get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM FinancialRecord WHERE EmployeeID=?", (employee_id,))
        rows = cursor.fetchall()
        return [
            {
                "RecordID": row[0],
                "EmployeeID": row[1],
                "RecordDate": row[2],
                "Description": row[3],
                "Amount": row[4],
                "RecordType": row[5]
            }
            for row in rows
        ]
    
    def get_financial_records_for_date(self, record_date):
        conn = DBConnUtil.get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM FinancialRecord WHERE RecordDate=?", (record_date,))
        rows = cursor.fetchall()
        return [
            {
                "RecordID": row[0],
                "EmployeeID": row[1],
                "RecordDate": row[2],
                "Description": row[3],
                "Amount": row[4],
                "RecordType": row[5]
            }
            for row in rows
        ]
