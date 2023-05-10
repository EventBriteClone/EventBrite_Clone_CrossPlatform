///events/live-events/

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../helper/api.dart';
import '../../models/basic_info_form.dart';
import '../../models/event_model.dart';
import '../../providers/token_provider.dart';

///[AllDraftEventsServices] is a class related to draft events
///It consists of a m[Future] method of type [BasicInfoFormData] which is [getAllDraftEvents]
///It saves data from the get request using [Api] class in a [Map] of [String] as key and [dynamic] as value
///It iterates around [data['result']] in order to save all draft events in the list of [eventDraftsList]
///The method returns a [List] at the end of all draft events

class AllLiveEventsServices {
  Future<List<EventModel>> getAllLiveEvents(BuildContext context) async {
    String? token = Provider.of<TokenModel>(context).token;
    List<dynamic> data = await Api().getM(
        url: 'https://event-us.me:8000/eventmanagement/creatorUpcomingEvents/',
        token:
            'CustomToken $token');

    //List<dynamic> data = (dataUnFiltered['results']);

    List<EventModel> eventLiveList = [];
    for (int i = 0; i < data.length; i++) {
      eventLiveList.add(
        EventModel.fromJson(data[i]),
      );
    }
    return eventLiveList;
  }
}
