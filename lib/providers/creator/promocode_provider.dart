import 'dart:io';

import 'package:event_brite_app/models/tickets_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';
import '../../models/promocode_model.dart';

///This is a [Provider] class of [PromoCodeProviderModel] that extends [ChangeNotifier]
///It includes all data related to the date and time in the section 3 of the form page
///It has the following:
///  *  [_revealHidden]  of type [bool]
///  *  [_discountAmountPercController] of type  [TextEditingController]
///  *  [_discountAmountPriceController] of type  [TextEditingController]
///  *  [_promoCodeStart] , [_promoCodeEnd], [_applyCodeTo] , [_ticketLimit] as [String]
///  *  [_limitedAmount] as [int]
///  *  [_codeName] of type  [TextEditingController] to get the time of the pricee entered by the user
///They all have setters and getters
///We have [saveData] method to save data into the form using [TicketsModel]

class PromoCodeProviderModel extends ChangeNotifier {
  int? _eventId;
  bool? _startsNow = true;
  bool? _startScheduled = false;
  bool? _endsNow = true;
  bool? _endsSheduled = false;
  bool? _revealHidden = false;
  String? _ticketLimit = ticketLimitList[0];
  File? _csvFile;
  String? _filePath;

  final TextEditingController _discountAmountPerc = TextEditingController();
  final TextEditingController _discountAmountPrice = TextEditingController();
  final TextEditingController _codeName = TextEditingController();
  final TextEditingController _limitAmount = TextEditingController();

//setters:

  set revealHidden(bool value) {
    _revealHidden = value;
    notifyListeners();
  }

  set ticketLimit(String value) {
    _ticketLimit = value;
    notifyListeners();
  }

  set discountAmountPerc(String value) {
    _discountAmountPerc.text = value;
    notifyListeners();
  }

  set discountAmountPrice(String value) {
    _discountAmountPrice.text = value;
    notifyListeners();
  }

  set codeName(String value) {
    _codeName.text = value;
    notifyListeners();
  }

  set limitAmount(String value) {
    _limitAmount.text = value;
    notifyListeners();
  }

  set csvFile(File? value) {
    _csvFile = value;
    notifyListeners();
  }

  set filePath(String? value) {
    _filePath = value;
    notifyListeners();
  }

  set startsNow(bool value) {
    _startsNow = value;
    notifyListeners();
  }

  set endsNow(bool value) {
    _endsNow = value;
    notifyListeners();
  }

  set startScheduled(bool value) {
    _startScheduled = value;
    notifyListeners();
  }

  set endsSheduled(bool value) {
    _endsSheduled = value;
    notifyListeners();
  }

  set eventId(int? value) {
    _eventId = value;
    notifyListeners();
  }

  //getters:
  int? get eventId => _eventId;
  String get ticketLimit => _ticketLimit!;
  bool get revealHidden => _revealHidden!;
  bool get endsSheduled => _endsSheduled!;
  bool get startScheduled => startScheduled;
  bool get endsNow => _endsNow!;
  bool get startsNow => _startsNow!;

  File? get csvFile => _csvFile;
  String? get filePath => _filePath;

  TextEditingController get codeNameController => _codeName;
  TextEditingController get discountAmountPercController => _discountAmountPerc;
  TextEditingController get discountAmountPriceController =>
      _discountAmountPrice;
  TextEditingController get limitAmountController => _limitAmount;

  final PromoCodeModel _formData = PromoCodeModel();

  PromoCodeModel get formData => _formData;

  // //saving to backend:
  void saveData(
    String? codeName,
    String? discountAmountPerc,
    String? discountAmountPrice,
    String? limitAmount,
    TextEditingController? dateControllerStart,
    TextEditingController? dateControllerEnd,
    TextEditingController? timeControllerStart,
    TextEditingController? timeControllerEnd,
    bool? revealHidden,
    bool? endsSheduled,
    bool? startScheduled,
    bool? endsNow,
    bool? startsNow,
    String? ticketLimit,
    File? csvFile,
  ) {
    if (revealHidden == true) {
      _formData.revealHidden = "True";
    } else {
      _formData.revealHidden = "False";
    }

    _formData.codeName = codeName;
    print(discountAmountPerc);
    _formData.discountAmount = int.parse(discountAmountPerc!);
    _formData.discountPrice = double.parse(discountAmountPrice!);

    _formData.csvFile = csvFile;
    _formData.limitAmount = int.parse(limitAmount!);
    _formData.limitedOrUn = ticketLimit;
    _formData.quantityAvailable = int.parse(limitAmount);

    if (startsNow == true) {
      _formData.starts = "now";
    }

    if (startScheduled == true) {
      _formData.starts = "scheduled";
    }

    if (endsNow == true) {
      _formData.ends = "When ticket sales end";
    }
    if (endsSheduled == true) {
      _formData.ends = "scheduled";
    }

    if (dateControllerStart!.text.isNotEmpty) {
      _formData.codeStart = DateTime.parse(dateControllerStart.text);
    }
    if (dateControllerEnd!.text.isNotEmpty) {
      _formData.codeEnd = DateTime.parse(dateControllerEnd.text);
    }

    if (timeControllerStart!.text.isNotEmpty) {
      _formData.startTime = TimeOfDay.fromDateTime(
          DateFormat('h:mm a').parse(timeControllerStart.text));
    }
    if (timeControllerEnd!.text.isNotEmpty) {
      _formData.endTime = TimeOfDay.fromDateTime(
          DateFormat('h:mm a').parse(timeControllerEnd.text));
    }

    notifyListeners();
  }
}



/*

we have textcontrollers:  name,disocunt amount and price, dates, we have 5 checkboxes and 1 drop down

{
    "ID": "7315",
    "EVENT_ID": "3656",
    "User_ID": "5",
    "CODE": "event09876544444",
    "Ticket_limit": "",
    "Limitedamount": null,
    "Reveal_hidden": "",
    "Discountـpercentage": null,
    "Discount_price": null,
    "Starts": "now",
    "Ends": "",
    "start_date": null,
    "start_time": null,
    "end_date": null,
    "end_time": null,
    "Quantity_available": null,
    "file": null
},

what is needed:
code name => can be required or not 3la 7asb upload csv wala la2
csv file  =>  nfs elkalam + its missing asln
precent off AW  discount amount  ==> mfrod eluser hy5ar 7aga w7da bs menhom bs MUST CHOOSE ONE (ONLY ONE) fa brdo idk tthandle how
Ticket limit ===> options [Unlimited, Limited to]
Limit Amount  ==> lao hoa e5tar limited to htb2a required lao ma5trsh msh htb2a required
Boolean Reveal hidden tickets
fe checkbox brdo => promocode starts [Now, Scheduled]
                  w lao user e5tar scheduled elmfrod yzhrlo startdate starttime  w mfrod yb2o required
another checkbox => promocode ends  [Now, Scheduled]
                  w lao user e5tar scheduled elmfrod yzhrlo [enddate endtieme]  w mfrod yb2o required

*/