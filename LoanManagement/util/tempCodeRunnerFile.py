import pyodbc

class DBConnUtil:
    @staticmethod
    def get_connection():
        return pyodbc.connect(
    r"DRIVER={ODBC Driver 17 for SQL Server};"
    r"SERVER=LAPTOP-4356KD57\SQLEXPRESS;" 
    r"DATABASE=LoanManagement;"  
    r"Trusted_Connection=yes;"
)