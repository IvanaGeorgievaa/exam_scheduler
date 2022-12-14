import 'package:lab_3_191118/model/exam.dart';
import 'package:lab_3_191118/model/user.dart';

class ExamSchedulerData {
  static String title = "Exam Organizer";
  static List<User> users = [
    User("Ivana", "Test123!"),
    User("Sara", "Test123!"),
    User("Ana", "Test123!"),
  ];

  static List<Exam> exams = [
    Exam('Software quality and testing', DateTime(2022, 12, 6, 17, 30),
        users[2]),
    Exam('Web Programming', DateTime(2022, 12, 8, 10, 30), users[1]),
    Exam('Ethics', DateTime(2022, 12, 7, 21, 08), users[1]),
    Exam(
        'Mobile Information Systems', DateTime(2022, 12, 12, 09, 00), users[0]),
    Exam('Data Science', DateTime(2022, 12, 13, 09, 00), users[0]),
    Exam('Computer ethics', DateTime(2022, 12, 15, 09, 00), users[0]),
  ];
}
