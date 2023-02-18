import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lab_3_191118/model/user.dart';

class Exam {
  final String _subjectName;
  final DateTime _dateTime;
  final User _user;
  late LatLng location;

  Exam(this._subjectName, this._dateTime, this._user, this.location);

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
