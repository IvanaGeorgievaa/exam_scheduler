import 'package:flutter/material.dart';
import 'package:lab_3_191118/model/user.dart';
import 'package:lab_3_191118/screens/calendar.dart';
import '../data/exams_data.dart';
import '../model/exam.dart';

import '../services/notification_service.dart';
import '../utils/notifications.dart';
import '../widgets/create_exam_form.dart';
import 'authentication.dart';
import 'list_exams.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final String _title = ExamSchedulerData.title;
  final List<Exam> _exams = ExamSchedulerData.exams;
  final List<User> _users = ExamSchedulerData.users;

  bool _pressed = false;
  var _isLogged = false;
  User? _currUser;

  void _addNewExamWithArgs(subjectName, dateAndTime, location) {
    var newExam = Exam(subjectName, dateAndTime, _currUser!, location);
    setState(() {
      _exams.add(newExam);
      _pressed = !_pressed;
    });
    NotificationApi.scheduleNotification(newExam);
  }

  bool _login(User user) {
    for (var u in _users) {
      if (u.username == user.username && u.password == user.password) {
        _currUser = user;
        return true;
      }
    }
    return false;
  }

  bool _register(User user) {
    for (var u in _users) {
      if (u.username == user.username && u.password == user.password) {
        return false;
      }
    }
    setState(() {
      _users.add(user);
    });
    return true;
  }

  void _setCurrentUser() {
    setState(() {
      _isLogged = true;
    });
  }

  void _logout(BuildContext context) {
    setState(() {
      _currUser = null;
      _isLogged = false;
    });
    NotificationApi.cancelNotifications();
  }

  void _openCalendar(BuildContext context) {
    Navigator.of(context).pushNamed(CalendarScreen.routeName,
        arguments: _exams
            .where((element) => element.getUser.username == _currUser!.username)
            .toList());
  }

  void _isPressed(BuildContext context) {
    setState(() {
      _pressed = !_pressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    NotificationApi.init();
    NotificationApi.scheduleNotifications(_exams);

    return _isLogged
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(_title),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    return _isPressed(context);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () {
                    return _openCalendar(context);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    return _logout(context);
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                _pressed ? NewExamScreen(_addNewExamWithArgs) : const Text(""),
                Expanded(
                  child: ListExamScreen(_exams
                      .where((element) =>
                          element.getUser.username == _currUser!.username)
                      .toList()),
                ),
                Center(
                    child: ElevatedButton(
                  child: const Text('Show notifications'),
                  onPressed: () {
                    NotificationService().showNotification(
                        title: 'Exam Notification',
                        body: 'You have an exam today');
                  },
                )),
              ],
            ),
          )
        : AuthenticationScreen(_login, _register, _setCurrentUser);
  }
}
