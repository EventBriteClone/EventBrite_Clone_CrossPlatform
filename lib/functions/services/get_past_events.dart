///events/live-events/

import 'dart:convert';

import 'package:http/http.dart';

import '../../helper/api.dart';
import '../../models/basic_info_form.dart';
import '../../models/event_model.dart';

///[AllDraftEventsServices] is a class related to draft events
///It consists of a m[Future] method of type [BasicInfoFormData] which is [getAllDraftEvents]
///It saves data from the get request using [Api] class in a [Map] of [String] as key and [dynamic] as value
///It iterates around [data['result']] in order to save all draft events in the list of [eventDraftsList]
///The method returns a [List] at the end of all draft events

class AllPastEventsServices {
  Future<List<EventModel>> getAllPastEvents() async {
    List<dynamic> data = await Api().getM(
        url: 'https://event-us.me:8000/eventmanagement/creatorPastEvents/',
        token:
            'CustomToken af2ae025cdc6bb4f7424909e533be0bdac61655418beae85cd689a16ee2b614b');

    //List<dynamic> data = (dataUnFiltered['results']);

    List<EventModel> eventPastList = [];
    for (int i = 0; i < data.length; i++) {
      eventPastList.add(
        EventModel.fromJson(data[i]),
      );
    }
    return eventPastList;
  }
}
