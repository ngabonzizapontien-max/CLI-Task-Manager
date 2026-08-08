import 'dart:io';

void main() {
  bool isRunning = true;
  while (isRunning) {
    print(""" 
    1. Add Student 
    2. View Students
    3. update Students
    4. Delete Student 
    5. Add teacher 
    6. Delete Teacher
    7. View Teachers
    8. View Courses
    9. Add Courses
    10. Exit 
    """);

    print("Choose an option: ");
    int choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        addStudent();
        break;
      case 2:
        runApp();
        break;
      case 3:
        addStudent();
        break;
      case 4:
        print("Delete in process");
        break;

      case 5:
        addTeacher();
        break;
      case 6:
        print("Delete in process");
        break;
      case 7:
        runApp();
        break;
      case 8:
        runApp();
        break;
      case 9:
        addCourses();
        break;
      case 10:
        print("Bye Byeee");
        print("Thanks for using our service!");
        isRunning = false;
        break;
      default:
        print("Invalid Inputs");
    }

    runApp();
  }
}

class Student {
  late String firstName;
  late String secondName;
  late int age;
  int grade;
  late int notes;
  late String studentId;

  Student(
    this.studentId,
    this.firstName,
    this.secondName,
    this.age,
    this.grade,
    this.notes,
  );

  String studentDetails() {
    return ("ID: $studentId, First Name: $firstName, Second Name: $secondName, Age: $age, Grade: $grade, Notes: $notes");
  }

  int updateGrade(int newGrade) {
    if (newGrade > grade) {
      grade = newGrade;
    }
    return grade;
  }
}

class Teacher {
  late String teacherId;
  late String teacherFullName;
  late int age;
  String domain;

  Teacher(this.age, this.domain, this.teacherFullName, this.teacherId);

  String display() {
    return ("\n ID: $teacherId\n Name: $teacherFullName,\n Domain: $domain,\n Age: $age");
  }
}

class Course {
  late String courseName;
  late String courseCode;
  late String credits;
  late String courseTeacher;

  Course(this.courseCode, this.courseName, this.courseTeacher, this.credits);

  String display() {
    return ("\nName: $courseName,\n Code: $courseCode,\n Credits: $credits,\n Teacher: $courseTeacher\n");
  }
}

class Enrollment {}

List<Student> students = [];
void addStudent() {
  print("Add a new student ");

  Student student = Student("", "", "", 0, 0, 0);

  print("Enter age: ");
  student.age = int.parse(stdin.readLineSync()!);
  print("Enter name: ");
  student.firstName = stdin.readLineSync()!;
  print("Enter name2: ");
  student.secondName = stdin.readLineSync()!;
  print("Enter grade: ");
  student.grade = int.parse(stdin.readLineSync()!);
  print("Enter notes: ");
  student.notes = int.parse(stdin.readLineSync()!);
  print("Enter ID Student: ");
  student.studentId = stdin.readLineSync()!;

  students.add(student);
  print("\nCongratulations! Successfully added.");
}

List<Teacher> teachers = [];
void addTeacher() {
  Teacher teacher = Teacher(0, "", "", "");
  print("Want to add new Teacher? ");
  print("Enter age: ");
  teacher.age = int.parse(stdin.readLineSync()!);
  print("Enter domain teaching: ");
  teacher.domain = stdin.readLineSync()!;
  print("Enter fullNameTeacher: ");
  teacher.teacherFullName = stdin.readLineSync()!;
  print("Enter ID-Teacher: ");
  teacher.teacherId = stdin.readLineSync()!;

  teachers.add(teacher);
  print("Congratulations! Successfully added.");
}

List<Course> courses = [];
void addCourses() {
  Course course = Course("", "", "", "");
  print("Do you awant to add a new course: ");

  print("Enter name Course: ");
  course.courseName = stdin.readLineSync()!;
  print("Enter Code Course: ");
  course.courseCode = stdin.readLineSync()!;
  print("Enter Teacher Course: ");
  course.courseTeacher = stdin.readLineSync()!;
  print("Enter Credits: ");
  course.credits = stdin.readLineSync()!;

  courses.add(course);
  print("Congratulations! Successfully added!");
}

void runApp() {
  for (Student student in students) {
    print(student.studentDetails());
  }
  for (Teacher teacher in teachers) {
    print(teacher.display());
  }
  for (Course course in courses) {
    print(course.display());
  }
}
