import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/constants.dart';
import '../utils/date_time.dart';

class DateSelectionWidget extends StatefulWidget {
  const DateSelectionWidget({Key? key}) : super(key: key);

  @override
  _DateSelectionWidgetState createState() => _DateSelectionWidgetState();
}

class _DateSelectionWidgetState extends State<DateSelectionWidget> {
  bool _isChecked1 = false;
  bool _isChecked2 = false;

  final TextEditingController _dateControllerStart = TextEditingController();
  final TextEditingController _timeControllerStart = TextEditingController();
  final TextEditingController _dateControllerEnd = TextEditingController();
  final TextEditingController _timeControllerEnd = TextEditingController();

  DateTime _dateTime = DateTime.now();

  void _showDatePickerStart() {
    showDatePickerStart(context).then((value) {
      if (value != null) {
        setState(() {
          _dateTime = value;
          _dateControllerStart.text = DateFormat('yyyy-MM-dd').format(value);
        });
      } else {
        setState(() {
          _dateTime = DateTime.now();
          _dateControllerStart.text =
              DateFormat('yyyy-MM-dd').format(_dateTime);
        });
      }
    });
  }

  void _showDatePickerEnd() {
    showDatePickerEnd(context).then((value) {
      if (value != null) {
        setState(() {
          _dateTime = value;
          _dateControllerEnd.text = DateFormat('yyyy-MM-dd').format(value);
        });
      } else {
        setState(() {
          _dateTime = DateTime.now();
          _dateControllerEnd.text = DateFormat('yyyy-MM-dd').format(_dateTime);
        });
      }
    });
  }

  TimeOfDay _timeOfDay = const TimeOfDay(hour: 8, minute: 30);
  void _showTimePickerStart() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then(
      (value) {
        setState(() {
          _timeOfDay = value!;
          _timeControllerStart.text = _timeOfDay.format(context);
        });
      },
    );
  }

  void _showTimePickerEnd() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then(
      (value) {
        setState(() {
          _timeOfDay = value!;
          _timeControllerEnd.text = _timeOfDay.format(context);
        });
      },
    );
  }

  ///to access time of day we use=> _timeOfDay.format(context).toString()

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,

      ///For a single event:
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: TextFormField(
                  onTap: _showDatePickerStart,
                  controller: _dateControllerStart,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.calendar_month_outlined),
                    labelText: 'Event Starts *  ',
                    hintText: '05/02/2023',
                    labelStyle: TextStyle(
                      fontSize: 18,
                    ),
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 32, horizontal: 10),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: TextFormField(
                  onTap: _showTimePickerStart,
                  controller: _timeControllerStart,
                  decoration: const InputDecoration(
                    labelText: 'Start Time',
                    hintText: '7:00 PM',
                    labelStyle: TextStyle(
                      fontSize: 18,
                    ),
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 32, horizontal: 10),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: TextFormField(
                  onTap: _showDatePickerEnd,
                  controller: _dateControllerEnd,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.calendar_month_outlined),
                    hintText: '05/02/2023',
                    labelText: 'Event Ends * ',
                    labelStyle: TextStyle(
                      fontSize: 18,
                    ),
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 32, horizontal: 10),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: TextFormField(
                  onTap: _showTimePickerEnd,
                  controller: _timeControllerEnd,
                  decoration: const InputDecoration(
                    labelText: 'End Time  ',
                    hintText: ' 10:00 PM',
                    labelStyle: TextStyle(
                      fontSize: 18,
                    ),
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 32, horizontal: 10),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ListTile(
          // ignore: prefer_const_constructors
          title: const Text(
              'Display start time. \n  The start time of your event will be displayed to attendees.',
              style: TextStyle(fontSize: 16, fontFamily: "Poppins")),
          leading: Checkbox(
            value: _isChecked1,
            onChanged: (value) {
              setState(() {
                _isChecked1 = value!;
              });
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ListTile(
          // ignore: prefer_const_constructors
          title: const Text(
              'Display end time. \n The end time of your event will be displayed to attendees.',
              style: TextStyle(fontSize: 16, fontFamily: "Poppins")),
          leading: Checkbox(
            value: _isChecked2,
            onChanged: (value) {
              setState(() {
                _isChecked2 = value!;
              });
            },
          ),
        ),
      ],

      ///missing time zone + event language ====> idk if need api or wait for backend to do them? or if we will need them?
    );
  }
}
