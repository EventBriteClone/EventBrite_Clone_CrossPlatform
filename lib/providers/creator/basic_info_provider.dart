import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/basic_info_form.dart';

///This is a provider class for the basic info form data for state managment in order to be able to transfer data to another page
/// [_formData] is a private object of type [BasicInfoFormData] that holds the form data and we have public getter that returns form data
/// It has a [saveData] method in order to save form data and display it elsewhere (Basic info part only)
/// It will notify all listerners that data has changed using [notifyListeners] method

class BasicInfoFormDataProvider extends ChangeNotifier {
  final BasicInfoFormData _formData = BasicInfoFormData();

  BasicInfoFormData get formData => _formData;

  void saveData(
    String eventTitle,
    String category,
    String type,
    String venueLocation,
    TextEditingController dateControllerStart,
    TextEditingController dateControllerEnd,
    TextEditingController timeControllerStart,
    TextEditingController timeControllerEnd,
    bool displayStartTimeSingle,
    bool displayEndTimeSingle,
    bool displayEndTimeRecurring,
    String singleOrRecurring,
    String organzier,
    String status,
    String online,
  ) {
    _formData.status = status;
    _formData.online = online;
    _formData.eventTitle = eventTitle;
    _formData.category = category;
    _formData.type = type;
    _formData.venueLocation = venueLocation;
    _formData.organizer = organzier;
    if (dateControllerStart.text.isNotEmpty) {
      _formData.eventStart = DateTime.parse(dateControllerStart.text);
    } else {
      //_formData.eventStart = dateControllerStart as DateTime?;
    }
    if (dateControllerEnd.text.isNotEmpty) {
      _formData.eventEnd = DateTime.parse(dateControllerEnd.text);
    } else {
      // _formData.eventEnd = dateControllerEnd as DateTime?;
    }

    if (timeControllerStart.text.isNotEmpty) {
      _formData.startTime = TimeOfDay.fromDateTime(
          DateFormat('h:mm a').parse(timeControllerStart.text));
    } else {
      // _formData.startTime = timeControllerStart as TimeOfDay?;
    }
    if (timeControllerEnd.text.isNotEmpty) {
      _formData.endTime = TimeOfDay.fromDateTime(
          DateFormat('h:mm a').parse(timeControllerEnd.text));
    } else {
      // _formData.endTime = timeControllerEnd as TimeOfDay?;
    }

    // _formData.eventStart = DateTime.parse(dateControllerStart.text);
    // _formData.eventEnd = DateTime.parse(dateControllerEnd.text);
    // _formData.startTime = TimeOfDay.fromDateTime(
    //     DateFormat('h:mm a').parse(timeControllerStart.text));
    // _formData.endTime = TimeOfDay.fromDateTime(
    //     DateFormat('h:mm a').parse(timeControllerEnd.text));
    _formData.display_start_time_Single = displayStartTimeSingle;
    _formData.display_end_time_Single = displayEndTimeSingle;
    _formData.display_end_time_Recurring = displayEndTimeRecurring;
    _formData.singleOrRecurring = singleOrRecurring;
    notifyListeners();
  }

  // void saveDataRecurring(String eventTitle, String category, String type,
  //     String venueLocation, bool displayEndTimeRecurring) {
  //   _formData.eventTitle = eventTitle;
  //   _formData.category = category;
  //   _formData.type = type;
  //   _formData.venueLocation = venueLocation;
  //   _formData.display_end_time_Recurring = displayEndTimeRecurring;

  //   notifyListeners();
  // }
}



//we have many cases:
//1. user fills everything in single date
//2. user chose recurring date and (date fields are now empty)
//3, user leaves location or type empty
//4. user choose online event or to be annonuced 