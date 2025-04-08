import pyodbc

server = 'LAPTOP-4356KD57\SQLEXPRESS'
database = 'studentmanagement'
username = ''
password = ''
driver = '{SQL Server}'

conn = pyodbc.connect(
    f'DRIVER={driver};'
    f'SERVER={server};'
    f'DATABASE={database};'
    f'UID={username};'
    f'PWD={password}'
)

cursor = conn.cursor()

def create_student(student_id, name, age, major):
    cursor.execute("INSERT INTO Students (Id, Name, Age, Major) VALUES (?, ?, ?, ?)", 
                   (student_id, name, age, major))
    conn.commit()
    print("Student Added!")

def read_students():
    cursor.execute("SELECT * FROM Students")
    for row in cursor.fetchall():
        print(row)

def update_student(student_id):
    print("Which field do you want to update?")
    print("1. Name")
    print("2. Age")
    print("3. Major")
    choice = input("Enter choice (1/2/3): ")

    if choice == '1':
        new_name = input("Enter new name: ")
        cursor.execute("UPDATE Students SET Name = ? WHERE Id = ?", (new_name, student_id))
    elif choice == '2':
        new_age = int(input("Enter new age: "))
        cursor.execute("UPDATE Students SET Age = ? WHERE Id = ?", (new_age, student_id))
    elif choice == '3':
        new_major = input("Enter new major: ")
        cursor.execute("UPDATE Students SET Major = ? WHERE Id = ?", (new_major, student_id))
    else:
        print("Invalid choice")
        return

    conn.commit()
    print("Student Updated")

def delete_student(student_id):
    cursor.execute("DELETE FROM Students WHERE Id = ?", (student_id,))
    conn.commit()
    print("Student Deleted!")

# Example operations
create_student(1, "Kunal", 19, "Mechanical Engineering")
create_student(2, "Riya", 20, "Information Technology")
create_student(3, "Tanvi", 21, "Electronics")
create_student(4, "Nikhil", 22, "Civil Engineering")
create_student(5, "Meera", 23, "Architecture")

read_students()
update_student(1)
read_students()
delete_student(1)
read_students()