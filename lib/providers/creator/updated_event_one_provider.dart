import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';
import '../../models/basic_info_form.dart';

///This is a provider class for the basic info form data for state managment in order to be able to transfer data to another page
/// [_formData] is a private object of type [BasicInfoFormData] that holds the form data and we have public getter that returns form data
/// It has a [saveData] method in order to save form data and display it elsewhere (Basic info part only)
/// It will notify all listerners that data has changed using [notifyListeners] method

class UpdatedEventOneProvider extends ChangeNotifier {
  BasicInfoFormData? _previousBasicInfo;
  BasicInfoFormData? get previousEventData => _previousBasicInfo;
  set previousEventData(BasicInfoFormData? value) {
    _previousBasicInfo = value;
    notifyListeners();
  }
  
   

  int? _eventId;
  String? _organizer = Organizer[0];
  String _type = type[0];
  String _category = category[0];
  String _selectedLocationInput = '';
  String _selectedLocation = 'Venue';
  String _status = 'Draft';
  String _online = 'False';

  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventLocationController =
      TextEditingController();

  int? get eventId => _eventId;
  String get organizer => _organizer!;
  String get typee => _type;
  String get categoryy => _category;
  String get status => _status;
  String get online => _online;
  String get selectedLocationInput => _selectedLocationInput;
  String get selectedLocation => _selectedLocation;
  TextEditingController get eventNameController => _eventNameController;
  TextEditingController get eventLocationController => _eventLocationController;

  set eventId(int? value) {
    _eventId = value;
    notifyListeners();
  }

  set organizer(String value) {
    _organizer = value;
    notifyListeners();
  }

  set online(String value) {
    _online = value;
    notifyListeners();
  }

  set status(String value) {
    _status = value;
    notifyListeners();
  }

  set selectedLocationInput(String value) {
    _selectedLocationInput = value;
    notifyListeners();
  }

  set selectedLocation(String value) {
    _selectedLocation = value;
    notifyListeners();
  }

  set eventName(String value) {
    _eventNameController.text = value;
    notifyListeners();
  }

  set eventLocation(String value) {
    _eventLocationController.text = value;
    notifyListeners();
  }

  set typee(String value) {
    _type = value;
    notifyListeners();
  }

  set categoryy(String value) {
    _category = value;
    notifyListeners();
  }

  

  final BasicInfoFormData _formData = BasicInfoFormData();

  BasicInfoFormData get formData => _formData;

  void saveData(
    //int eventID,
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
    }
    if (dateControllerEnd.text.isNotEmpty) {
      _formData.eventEnd = DateTime.parse(dateControllerEnd.text);
    }

    if (timeControllerStart.text.isNotEmpty) {
      _formData.startTime = TimeOfDay.fromDateTime(
          DateFormat('h:mm a').parse(timeControllerStart.text));
    }
    if (timeControllerEnd.text.isNotEmpty) {
      _formData.endTime = TimeOfDay.fromDateTime(
          DateFormat('h:mm a').parse(timeControllerEnd.text));
    }

    _formData.display_start_time_Single = displayStartTimeSingle;
    _formData.display_end_time_Single = displayEndTimeSingle;
    _formData.display_end_time_Recurring = displayEndTimeRecurring;

    notifyListeners();
  }
}
