class Student {
    String studentId;
    ...
}
class Teacher {
    String teacherId;
    Vector studentsTaught;
    public String getId() {
        return teacherId;
    }
    public void addStudent(Student student) {
        studentsTaught.add(student);
    }
}

class GraduateStudent extends Student {
    
}

class GraduateTeacher extends Teacher {
    public void addGraduateStudent(GraduateStudent student) {
        addStudent(student);
    }
}