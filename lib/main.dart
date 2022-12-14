import 'package:flutter/material.dart';
import 'package:lab_3_191118/screens/authentication.dart';
import 'package:lab_3_191118/screens/calendar.dart';
import 'package:lab_3_191118/screens/home.dart';
import 'package:lab_3_191118/screens/list_exams.dart';
import 'package:lab_3_191118/utils/global_theme.dart';
import 'data/exams_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: globalTheme,
      home: const MyHomePage(title: 'Exam Organizer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: ExamSchedulerData.title,
        theme: globalTheme,
        routes: {
          AuthenticationScreen.routeName: (ctx) =>
              const AuthenticationScreen(null, null, null),
          ListExamScreen.routeName: (ctx) => ListExamScreen(List.empty()),
          CalendarScreen.routeName: (ctx) => const CalendarScreen(),
        },
        home: const MainScreen());
  }
}
