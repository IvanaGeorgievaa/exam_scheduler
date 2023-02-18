import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/exam.dart';
import '../utils/locations.dart';
import '../widgets/button.dart';
import '../widgets/text_inf.dart';
import 'maps.dart';

class DetailsExamScreen extends StatefulWidget {
  static const routeName = '/exam/details';

  const DetailsExamScreen({Key? key}) : super(key: key);

  @override
  State<DetailsExamScreen> createState() => _DetailsExamScreenState();
}

class _DetailsExamScreenState extends State<DetailsExamScreen> {
  late Exam _selectedExam;
  String? _selectedExamAddress;
  late BuildContext _buildContext;

  void _navigateToMap() async {
    LatLng? currentUserLocation = await LocationUtils.getCurrentLocation();
    Navigator.of(_buildContext).pushNamed(MapsExamScreen.routeName, arguments: [
      currentUserLocation,
      _selectedExam.location,
      _selectedExam.subjectName
    ]);
  }

  Future<void> _getLocationAddress() async {
    Address address =
        await LocationUtils.getLocationAddress(_selectedExam.location);

    setState(() {
      _selectedExamAddress =
          '${address.streetAddress}, ${address.city} (${address.countryCode})';
    });
  }

  @override
  Widget build(BuildContext context) {
    _selectedExam = ModalRoute.of(context)!.settings.arguments as Exam;
    _buildContext = context;
    _getLocationAddress();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Exam Details"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InfoText(
                          _selectedExam.subjectName,
                          const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(0, 0, 0, 1.0))),
                    ],
                  ),
                ),
                InfoText(
                    _selectedExam.dateAndTime,
                    const TextStyle(
                        fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1.0))),
                ButtonFormField(
                    const EdgeInsets.fromLTRB(0, 20.0, 0, 45),
                    _navigateToMap,
                    (_selectedExamAddress != null)
                        ? _selectedExamAddress!.toString()
                        : 'View Location',
                    Colors.black38,
                    Colors.white),
              ]),
        ),
      ),
    );
  }
}
