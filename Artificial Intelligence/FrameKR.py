class University:
    def __init__(self):
        self.university_name = "Tribhuvan University"
        self.location = "Kathmandu"
        self.established = 1959

class Institute(University):
    def __init__(self):
        super().__init__()
        self.institute = "Institute of Science and Technology"
        self.program = "BSc CSIT"
        
class Student(Institute):
    def __init__(self, name, roll, semester, college):
        super().__init__()
        self.name = name
        self.roll = roll
        self.semester = semester
        self.college = college
        self.department = "CSIT"
    def display(self):
        print("========== Student Frame ==========")
        print("Student Name :", self.name)
        print("Roll Number :", self.roll)
        print("Semester :", self.semester)
        print("Department :", self.department)
        print("College :", self.college)
        print("\n========== Institute Frame ==========")
        print("Institute :", self.institute)
        print("Program :", self.program)
        print("\n========== University Frame ==========")
        print("University :", self.university_name)
        print("Location :", self.location)
        print("Established :", self.established)
        
student1 = Student(
"Ram Sharma",
"TU078BCT001",
5,
"Deerwalk Institute of Technology"
)
student1.display()