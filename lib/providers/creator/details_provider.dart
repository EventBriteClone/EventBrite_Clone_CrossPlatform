import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/basic_info_form.dart';

///This is a provider class for the basic info form data for state managment in order to be able to transfer data to another page
/// [_formData] is a private object of type [BasicInfoFormData] that holds the form data and we have public getter that returns form data
///It has a [saveData] method to save data from the form for later use or to save to DP (Details part only)
/// It will notify all listerners that data has changed using [notifyListeners] method

class DetailsFormDataProvider extends ChangeNotifier {
  final TextEditingController _eventSummaryController = TextEditingController();
  final TextEditingController _eventDescController = TextEditingController();
  File? _eventImage;
  String? _imagePath;

  set eventImage(File? value) {
    _eventImage = value;
  }

  set imagePath(String? value) {
    _imagePath = value;
  }

  set eventSummary(String value) {
    _eventSummaryController.text = value;
    notifyListeners();
  }

  set eventDesc(String value) {
    _eventDescController.text = value;
    notifyListeners();
  }

  TextEditingController get eventSummaryController => _eventSummaryController;
  TextEditingController get eventDescController => _eventDescController;
  File? get eventImage => _eventImage;
  String? get imagePath => _imagePath;

  final BasicInfoFormData _formData = BasicInfoFormData();

  BasicInfoFormData get formData => _formData;

  void saveData(
    String? summary,
    String? eventDesc,
    File? eventImage,
  ) {
    _formData.summary = summary;
    _formData.eventDesc = eventDesc;
    _formData.eventImage = eventImage;
    notifyListeners();
  }

  void saveSummary(
    String eventSummary,
  ) {
    _formData.summary = eventSummary;
    notifyListeners();
  }

  void saveDesc(
    String eventDesc,
  ) {
    _formData.eventDesc = eventDesc;
    notifyListeners();
  }

  void saveImage(
    File eventImage,
  ) {
    _formData.eventImage = eventImage;
    notifyListeners();
  }
}
