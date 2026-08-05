students = ["Ram", "Hari"]
studies = {
"Ram": "AI",
"Hari": "DBMS"
}
teachers = {
"AI": "Sita",
"DBMS": "Gita"
}
name = input("Enter student name: ")
if name in studies:
    subject = studies[name]
    teacher = teachers[subject]
    print("Student:", name)
    print("Studies:", subject)
    print("Teacher:", teacher)
else:
    print("Student not found")