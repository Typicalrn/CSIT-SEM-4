%=========================================
% Knowledge Base (Facts)
%=========================================
student(ram).
student(hari).
student(sita).
teacher(gopal).
teacher(anita).
subject(ai).
subject(dbms).
studies(ram, ai).
studies(hari, dbms).
studies(sita, ai).
teaches(gopal, ai).
teaches(anita, dbms).
%=========================================
% Rules
%=========================================
knows(Student, Subject) :-
studies(Student, Subject).
teaches_student(Teacher, Student) :-
teaches(Teacher, Subject),
studies(Student, Subject).