import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class NewExamScreen extends StatefulWidget {
  final Function _callFunc;
  const NewExamScreen(this._callFunc, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NewExamScreenState(_callFunc);
}

class NewExamScreenState extends State<NewExamScreen> {
  String _subjectName = "";
  DateTime _dateAndTime = DateTime.now();
  final _format = DateFormat("yyyy-MM-dd HH:mm");
  final Function _callFunction;

  NewExamScreenState(this._callFunction);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Name'),
      validator: (val) {
        if (val!.isEmpty) {
          return 'Name is Required';
        }
      },
      onSaved: (val) {
        _subjectName = val!;
      },
    );
  }

  Widget _buildDateAndTime() {
    return DateTimeField(
      decoration: const InputDecoration(labelText: 'Date and Time'),
      format: _format,
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
        if (date != null) {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.combine(date, time);
        } else {
          return currentValue;
        }
      },
      onChanged: (val) => setState(() {
        _dateAndTime = DateTime.now();
      }),
      validator: (val) {
        if (val == DateTime.now()) {
          return 'Date and time field is Required';
        }
      },
      onSaved: (val) {
        _dateAndTime = val as DateTime;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Create new exam",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold),
            ),
            _buildName(),
            _buildDateAndTime(),
            const SizedBox(
              height: 20,
            ),
            // ignore: deprecated_member_use
            ElevatedButton(
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                _formKey.currentState!.save();

                _callFunction(_subjectName, _dateAndTime,
                    const LatLng(42.004227, 21.409944));
              },
            ),
          ],
        ),
      ),
    );
  }
}
