import 'package:event_brite_app/models/tickets_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///This is a [Provider] class of [TicketProviderModel] that extends [ChangeNotifier]
///It includes all data related to the date and time in the section 3 of the form page
///It has the following:
///  *  [_absorbFees]  of type [bool] to check if the absorb fees check box was selected or not
///  *  [_ticketNameController] of type  [TextEditingController] to get the data of the Ticket Namee entered by the user
///  *  [_availableQuantityController] of type  [TextEditingController] to get the data of the quantity entered by the user
///  *  [_priceController] of type  [TextEditingController] to get the time of the pricee entered by the user
///They all have setters and getters
///We have [saveData] method to save data into the form using [TicketsModel]

class UpdatedTicketProviderModel extends ChangeNotifier {
  bool _absorbFees = false;
  int? _ticketID;

  final TextEditingController _ticketNameController =
      TextEditingController(text: 'General Admission');
  final TextEditingController _availableQuantityController =
      TextEditingController(text: '0');
  final TextEditingController _priceController =
      TextEditingController(text: '0.00');

  final _quantitySold = 0;
  String? _ticketType;

  set absorbFees(bool value) {
    _absorbFees = value;
    notifyListeners();
  }

  set ticketID(int? value) {
    _ticketID = value;
    notifyListeners();
  }

  set ticketName(String value) {
    _ticketNameController.text = value;
    notifyListeners();
  }

  set availableQuantity(String value) {
    _availableQuantityController.text = value;
    notifyListeners();
  }

  set price(String value) {
    _priceController.text = value;
    notifyListeners();
  }

  set ticketType(String value) {
    _ticketType = value;
    notifyListeners();
  }

  String get ticketType => _ticketType!;
  int get quantitySold => _quantitySold;
  bool get absorbFees => _absorbFees;
  TextEditingController get ticketNameController => _ticketNameController;
  TextEditingController get availableQuantityController =>
      _availableQuantityController;
  TextEditingController get priceController => _priceController;
  int? get ticketID => _ticketID;

  final TicketsModel _formData = TicketsModel();

  TicketsModel get formData => _formData;

  void saveTicketID(
    int id,
  ) {
    _formData.id = id;
    notifyListeners();
  }

  //saving to backend:
  void saveData(
    TextEditingController ticketNameControl,
    TextEditingController priceControl,
    TextEditingController availableQuantityControl,
    TextEditingController dateControllerStart,
    TextEditingController dateControllerEnd,
    TextEditingController timeControllerStart,
    TextEditingController timeControllerEnd,
    bool absorbFees,
    int quantitySold,
    String ticketType,
  ) {
    if (absorbFees == true) {
      _formData.asborbFees = "True";
    } else {
      _formData.asborbFees = "False";
    }

    _formData.ticketType = ticketType;
    _formData.ticketName = ticketNameControl.text;
    _formData.price =
        double.parse(double.parse(priceControl.text).toStringAsFixed(2));
    _formData.capacity = int.parse(availableQuantityControl.text);
    _formData.quantitySold = 0;

    if (dateControllerStart.text.isNotEmpty) {
      _formData.salesStart = DateTime.parse(dateControllerStart.text);
    }
    if (dateControllerEnd.text.isNotEmpty) {
      _formData.salesEnd = DateTime.parse(dateControllerEnd.text);
    }

    if (timeControllerStart.text.isNotEmpty) {
      _formData.startTime = TimeOfDay.fromDateTime(
          DateFormat('h:mm a').parse(timeControllerStart.text));
    }
    if (timeControllerEnd.text.isNotEmpty) {
      _formData.endTime = TimeOfDay.fromDateTime(
          DateFormat('h:mm a').parse(timeControllerEnd.text));
    }

    notifyListeners();
  }
}
