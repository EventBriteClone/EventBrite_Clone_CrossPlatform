import 'dart:convert';

import 'package:event_brite_app/models/tickets_model.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../helper/api.dart';
import '../../models/basic_info_form.dart';
import '../../models/event_model.dart';
import '../../providers/creator/basic_info_provider.dart';
import '../../providers/token_provider.dart';

///[AllTicketsServices] is a class related to tickets
///It consists of a m[Future] method of type [TicketsModel] which is [getAllTickets]
///It saves data from the get request using [Api] class in a [Map] of [String] as key and [dynamic] as value

///The method returns a [List] at the end of all tickets

class AllTicketsServices {
  Future<List<TicketsModel>> getAllTickets(BuildContext context) async {
    final eventModel =
        Provider.of<BasicInfoFormDataProvider>(context, listen: false);
        String? token = Provider.of<TokenModel>(context).token;
        

    print("inside cget ticket");
    int? id;
    print(eventModel.formData.eventID);

    if (eventModel.eventId == 0 || eventModel.eventId == null) {
      id = eventModel.formData.eventID;
    } else {
      id = eventModel.eventId;
    }

    List<dynamic> data = await Api().getM(
        url: 'https://event-us.me:8000/events/ALLTickets/$id/',
        token:
            'CustomToken $token');

    //List<dynamic> data = (dataUnFiltered['results']);

    List<TicketsModel> ticketsList = [];
    for (int i = 0; i < data.length; i++) {
      ticketsList.add(
        TicketsModel.fromJson(data[i]),
      );
    }
    return ticketsList;
  }
}

/*
lis of maps
[
  {
    "ID": 2147483647,
    "event_id": 2147483647,
    "User_id": 2147483647,
    "NAME": "string",
    "PRICE": 0,
    "capacity": 2147483647,
    "quantity_sold": 2147483647,
    "TICKET_TYPE": "Free",
    "Sales_start": "2023-05-04",
    "Sales_end": "2023-05-04",
    "Start_time": "string",
    "End_time": "string",
    "Absorb_fees": "True"
  }
]

*/



