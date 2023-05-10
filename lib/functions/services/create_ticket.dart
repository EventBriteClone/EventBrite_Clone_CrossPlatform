import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../helper/api.dart';
import '../../models/tickets_model.dart';
import '../../providers/creator/basic_info_provider.dart';

/// [createTicketService] class for create a ticket [CreateTicket]
/// it uses [post] method from [Api]
/// it returns a [Future] of [dynamic] and we save the [id] when we get the [response]
///
///

class createTicketService {
  /// [ticketName] name of the ticket.
  /// [ticketType] type of the ticket, e.g. Free or Paid.
  /// [saleStart] start date of ticket sales.
  /// [saleEnd] end date of ticket sales.
  /// [startTime] start time of the event.
  /// [endTime] end time of the event.
  /// [quantitySold] number of tickets sold.
  /// [availableQunatity] number of tickets available for sale.
  /// [price] price of the ticket.
  /// [absorbFees] indicates whether fees are absorbed by the event.
  /// [context] current build context of the app.
  /// Returns a [Map] with [ID] of the ticket and [response] containing ticket data

  Future<dynamic> CreateTicket({
    required String? ticketName,
    required String? ticketType,
    required DateTime? saleStart, //should be string
    required DateTime? saleEnd, //should be string
    required TimeOfDay? startTime, //should be string
    required TimeOfDay? endTime, //should be string
    required int? quantitySold,
    required int? availableQunatity,
    required double? price,
    required String? absorbFees,
    required BuildContext context,
  }) async {
    final eventModel =
        Provider.of<BasicInfoFormDataProvider>(context, listen: false);

    String formattedDateStart = DateFormat('yyyy-MM-dd').format(saleStart!);
    String formattedDateEnd = DateFormat('yyyy-MM-dd').format(saleEnd!);

// Format the start and end times as --:-- --
    String formattedStartTime = DateFormat('hh:mm:ss')
        .format(DateTime(1, 1, 1, startTime!.hour, startTime.minute));
    String formattedEndTime = DateFormat('hh:mm:ss')
        .format(DateTime(1, 1, 1, endTime!.hour, endTime.minute));

    print("inside cget ticket");
    int? id;
    print(eventModel.formData.eventID);

    if (eventModel.eventId == 0 || eventModel.eventId == null) {
      id = eventModel.formData.eventID;
    } else {
      id = eventModel.eventId;
    }

    final response = await Api().post(
      url: 'https://event-us.me:8000/events/$id/Tickets/',
      body: {
        'NAME': ticketName,
        'PRICE': price.toString(),
        'capacity': availableQunatity.toString(),
        'quantity_sold': quantitySold.toString(),
        'TICKET_TYPE': ticketType,
        'Sales_start': formattedDateStart,
        'Sales_end': formattedDateEnd,
        'Start_time': formattedStartTime,
        'End_time': formattedEndTime,
        'Absorb_fees': absorbFees,
      },
      token:
          'CustomToken af2ae025cdc6bb4f7424909e533be0bdac61655418beae85cd689a16ee2b614b',
    );

    final responseData = response['response'];
    final ticketID = responseData['ID'];

    //return BasicInfoFormData.fromJson(response);
    return {'ID': ticketID, 'response': TicketsModel.fromJson(responseData)};

    // return TicketsModel.fromJson(response);
  }
}

/*
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

*/
