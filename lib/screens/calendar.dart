import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../model/exam.dart';

class CalendarScreen extends StatelessWidget {
  static const routeName = '/exams/calendar';

  const CalendarScreen({Key? key}) : super(key: key);

  List<Appointment> _appointments(List<Exam> exams) {
    List<Appointment> appointments = <Appointment>[];
    for (var exam in exams) {
      final DateTime startTime = exam.getDateAndTime;
      final DateTime endTime = startTime.add(const Duration(hours: 2));

      appointments.add(Appointment(
        startTime: startTime,
        endTime: endTime,
        subject: exam.subjectName,
        color: Colors.green,
      ));
    }

    return appointments;
  }

  @override
  Widget build(BuildContext context) {
    final exams = ModalRoute.of(context)!.settings.arguments as List<Exam>;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your schedule"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(9),
        child: SfCalendar(
          view: CalendarView.workWeek,
          firstDayOfWeek: 6,
          dataSource: AppointmentDataSource(_appointments(exams)),
        ),
      ),
    );
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
