import 'package:google_maps_flutter/google_maps_flutter.dart';
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
    Exam('Software quality and testing', DateTime(2023, 02, 20, 17, 30),
        users[2], const LatLng(42.004227, 21.409944)),
    Exam('Web Programming', DateTime(2023, 02, 21, 10, 30), users[1],
        const LatLng(41.993905, 21.424251)),
    Exam('Ethics', DateTime(2022, 12, 7, 21, 08), users[1],
        const LatLng(42.004227, 21.409944)),
    Exam('Mobile Information Systems', DateTime(2023, 02, 20, 09, 00), users[0],
        const LatLng(42.004227, 21.409944)),
    Exam('Data Science', DateTime(2022, 12, 13, 09, 00), users[0],
        const LatLng(41.993905, 21.424251)),
    Exam('Computer ethics', DateTime(2023, 02, 22, 09, 00), users[0],
        const LatLng(41.993905, 21.424251)),
  ];
}
