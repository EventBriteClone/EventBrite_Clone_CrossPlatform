import 'dart:convert';

import 'package:http/http.dart';
import 'package:organizer/models/basic_info_form.dart';

import '../helpers/api.dart';

///[AllDraftEventsServices] is a class related to draft events
///It consists of a m[Future] method of type [BasicInfoFormData] which is [getAllDraftEvents]
///It saves data from the get request using [Api] class in a [Map] of [String] as key and [dynamic] as value
///It iterates around [data['result']] in order to save all draft events in the list of [eventDraftsList]
///The method returns a [List] at the end of all draft events

class AllDraftEventsServices {
  Future<List<BasicInfoFormData>> getAllDraftEvents() async {
    Map<String, dynamic> data = await Api().get(
        url: 'https://event-us.me:8000/events/ALL/?STATUS=Draft',
        token: '55c8705b56499f311a6966ad60600d4c28b9f468');

    List<BasicInfoFormData> eventDraftsList = [];
    for (int i = 0; i < data['results'].length; i++) {
      eventDraftsList.add(
        BasicInfoFormData.fromJson(data['results'][i]),
      );
    }
    return eventDraftsList;
  }
}

/*
{
  "count": 3,
  "next": null,
  "previous": null,
  "results": [
    {
      "id": 1,
      "image": "/media/events/sunflower_a3EQauF.jpeg",
      "ID": 33,
      "User_id": 11,
      "Title": "fff",
      "organizer": "fff",
      "Summery": "fff",
      "Description": "fff",
      "type": "fff",
      "category_name": "fff",
      "sub_Category": "fff",
      "venue_name": "ffff",
      "ST_DATE": "2023-04-24",
      "END_DATE": "2023-05-03",
      "ST_TIME": "19:37:00",
      "END_TIME": "21:39:00",
      "online": "f",
      "CAPACITY": 500,
      "PASSWORD": "512002",
      "STATUS": "open"
    },
    {
      "id": 2,
      "image": "/media/events/sunflower_FuWmO7R.jpeg",
      "ID": 223,
      "User_id": 223,
      "Title": "rrrr",
      "organizer": "rrr",
      "Summery": "rrr",
      "Description": "rrr",
      "type": "rr",
      "category_name": "rr",
      "sub_Category": "rr",
      "venue_name": "rrrr",
      "ST_DATE": "2023-04-14",
      "END_DATE": "2023-04-21",
      "ST_TIME": "21:41:00",
      "END_TIME": "22:41:00",
      "online": "t",
      "CAPACITY": 444,
      "PASSWORD": "512002",
      "STATUS": "open"
    },
    {
      "id": 3,
      "image": "/media/events/photo-1533450718592-29d45635f0a9_0TZwT1K.jpeg",
      "ID": 321,
      "User_id": 1234,
      "Title": "rrr",
      "organizer": "rrr",
      "Summery": "vfvfb",
      "Description": "brtbtr",
      "type": "rtbtrb",
      "category_name": "ghrthb",
      "sub_Category": "brgnbrgn",
      "venue_name": "dfvdf",
      "ST_DATE": "2023-05-04",
      "END_DATE": "2023-05-08",
      "ST_TIME": "23:57:00",
      "END_TIME": "13:57:00",
      "online": "t",
      "CAPACITY": 3333,
      "PASSWORD": "512002",
      "STATUS": "Open"
    }
  ]
}

*/
