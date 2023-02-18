import 'package:flutter/material.dart';
import 'package:lab_3_191118/screens/exam_details.dart';

import '../model/exam.dart';

class ListExamScreen extends StatelessWidget {
  static const routeName = '/exams/list';
  final List<Exam> _exams;

  const ListExamScreen(this._exams, {Key? key}) : super(key: key);

  void _examDetails(BuildContext context, Exam exam) {
    Navigator.of(context)
        .pushNamed(DetailsExamScreen.routeName, arguments: exam);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: _exams.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _examDetails(context, _exams[index]),
          child: Card(
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    _exams[index].subjectName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: const Text(
                    "Date and Time:",
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                Text(
                  _exams[index].dateAndTime,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
