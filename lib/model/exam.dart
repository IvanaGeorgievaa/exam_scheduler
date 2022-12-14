import 'package:lab_3_191118/model/user.dart';

class Exam {
  final String _subjectName;
  final DateTime _dateTime;
  final User _user;

  Exam(this._subjectName, this._dateTime, this._user);

  String get subjectName {
    return _subjectName;
  }

  String get dateAndTime {
    return _dateTime.toString();
  }

  DateTime get getDateAndTime {
    return _dateTime;
  }

  User get getUser {
    return _user;
  }
}
