import 'package:flutter/material.dart';

Future<DateTime?> showDatePickerStart(BuildContext context) async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.utc(2050, 06, 16),
    initialEntryMode: DatePickerEntryMode.calendarOnly,
  );

  if (selectedDate != null) {
    return selectedDate;
  } else {
    return DateTime.now();
  }
}

Future<DateTime?> showDatePickerEnd(BuildContext context) async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.utc(2050, 06, 16),
    initialEntryMode: DatePickerEntryMode.calendarOnly,
  );

  if (selectedDate != null) {
    return selectedDate;
  } else {
    return DateTime.now();
  }
}
