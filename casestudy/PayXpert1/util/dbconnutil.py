
import pyodbc

class DBConnUtil:
    @staticmethod
    def get_connection():
        try:
            return pyodbc.connect(
                r"DRIVER={ODBC Driver 17 for SQL Server};"
                r"SERVER=localhost\SQLEXPRESS;"
                r"DATABASE=PayXpert3;"
                r"Trusted_Connection=yes;"
            )
        except pyodbc.Error as e:
            print('database connection failed')
