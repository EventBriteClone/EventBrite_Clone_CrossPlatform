import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class PromoCodeModel {
  String? codeName;
  String? limitedOrUn;
  int? limitAmount;
  String? revealHidden;
  double? discountPrice;
  int? discountAmount;
  String? starts;
  String? ends;
  DateTime? codeStart;
  DateTime? codeEnd;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  int? quantityAvailable;
  File? csvFile;
  int? id;

  PromoCodeModel({
    this.codeName,
    this.discountAmount, //percentage
    this.revealHidden,
    this.limitedOrUn,
    this.ends,
    this.limitAmount,
    this.quantityAvailable,
    this.starts,
    this.discountPrice, //price
    this.codeStart,
    this.codeEnd,
    this.startTime,
    this.endTime,
    this.csvFile,
    this.id,
  });

  factory PromoCodeModel.fromJson(jsonData) {
    return PromoCodeModel(
      id: jsonData['ID'],
      codeName: jsonData['CODE'],
      limitedOrUn: jsonData['Ticket_limit'],
      limitAmount: jsonData['Limitedamount'],
      revealHidden: jsonData['Reveal_hidden'],
      discountAmount: jsonData['Discountـpercentage'],
      discountPrice: jsonData['Discount_price'],
      starts: jsonData['Starts'],
      ends: jsonData['Ends'],
      codeStart: jsonData['start_date'],
      startTime: jsonData['start_time'],
      codeEnd: jsonData['end_date'],
      endTime: jsonData['end_time'],
      quantityAvailable: jsonData['Quantity_available'],
      csvFile: jsonData['file'],
    );
  }
}




/*
{
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
  
}
*/