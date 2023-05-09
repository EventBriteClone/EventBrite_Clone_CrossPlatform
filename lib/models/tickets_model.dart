import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

/// Here we save the data from the Ticket info that the user enters when creating a ticket
/// we have [ticketName] ,[salesStart], [salesEnd], [startTime], [endTime] , [price] , [capacity], [quantitySold]
/// And we have 1 checkboxes: [asborbFees]
/// [ticketType] indicates whether event is free or paid
class TicketsModel {
  String? ticketName;
  DateTime? salesStart;
  DateTime? salesEnd;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String? asborbFees;
  double? price;
  int? capacity;
  int? quantitySold;
  String? ticketType;
  int? id;

  TicketsModel({
    this.ticketName,
    this.price,
    this.quantitySold,
    this.capacity,
    this.salesStart,
    this.salesEnd,
    this.startTime,
    this.endTime,
    this.ticketType,
    this.asborbFees,
    this.id,
  });

  factory TicketsModel.fromJson(jsonData) {
    return TicketsModel(
      id: jsonData['ID'],
      ticketName: jsonData['NAME'],
      price: jsonData['PRICE'],
      capacity: jsonData['capacity'],
      quantitySold: jsonData['quantity_sold'],
      ticketType: jsonData['TICKET_TYPE'],
      salesStart: DateTime.parse(jsonData['Sales_start']),
      salesEnd: DateTime.parse(jsonData['Sales_end']),
      startTime: TimeOfDay.fromDateTime(
          DateTime.parse('1970-01-01 ${jsonData['Start_time']}')),
      endTime: TimeOfDay.fromDateTime(
          DateTime.parse('1970-01-01 ${jsonData['End_time']}')),
      asborbFees: jsonData['Absorb_fees'],
    );
  }
}



//the backend:
/*
{

   {
  "NAME": "string",
  "PRICE": 0,
  "capacity": 2147483647,
  "quantity_sold": 2147483647,
  "TICKET_TYPE": "Free",
  "Sales_start": "2023-05-03",
  "Sales_end": "2023-05-03",
  "Start_time": "2023-05-03T08:22:49.180Z",
  "End_time": "2023-05-03T08:22:49.180Z",
  "Absorb_fees": "True"
}

    "NAME": "",
    "PRICE": 500.0,
    "capacity": "500",
    "quantity_sold": "200",
    "TICKET_TYPE": "Paid",
    "Sales_start": "2023-05-01",
    "Sales_end": "2023-05-30",
    "Start_time": "2023-05-01T05:00:00Z",
    "End_time": "2023-05-30T06:00:00Z",
    "Absorb_fees": "False"
}
*/