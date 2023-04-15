import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:organizer/screens/creator/basic_info/basic_info.dart';

import '../helpers/api.dart';
import '../models/basic_info_form.dart';

class CreateEventService {
  Future<dynamic> createEvent({
    //things i already have and in api  ==> 12
    required String? eventTitle,
    required String? type,
    required String? category,
    required String? venueLocation,
    required DateTime? eventStart, //should be string
    required DateTime? eventEnd, //should be string
    required TimeOfDay? startTime, //should be string
    required TimeOfDay? endTime, //should be string
    required String? summary,
    required String? eventDesc,
    required File? eventImage, //should be a url string
    required String? organizer,
    required String? status,
    required String? online, //True False

    //things i have and not in api
    bool? display_start_time_Single,
    bool? display_end_time_Single,
    bool? display_end_time_Recurring,
    String? singleOrRecurring,

    //things in api but i dont have  ===> 6
    required int? User_id,
    required String? sub_Category,
    required int? CAPACITY,
    required String? PASSWORD,
  }) async {
// Format the start and end dates as dd/mm/yyyy
    String formattedDateStart = DateFormat('dd/MM/yyyy').format(eventStart!);
    String formattedDateEnd = DateFormat('dd/MM/yyyy').format(eventEnd!);

// Format the start and end times as --:-- --
    String formattedStartTime = DateFormat('hh:mm a')
        .format(DateTime(1, 1, 1, startTime!.hour, startTime.minute));
    String formattedEndTime = DateFormat('hh:mm a')
        .format(DateTime(1, 1, 1, endTime!.hour, endTime.minute));

    Map<String, dynamic> data = await Api().post(
        url: 'http://event-us.me:8000/events/create',
        body: {
          // "id": 0,
          "image":
              "https://127.0.0.1:8000/media/events/${eventImage!.path.split('/').last}",
          "ID": 2247453646.toString(),
          "User_id": 2247453646.toString(),
          "Title": eventTitle,
          "organizer": organizer,
          "Summery": summary,
          "Description": eventDesc,
          "type": type,
          "category_name": category,
          "sub_Category": ' ',
          "venue_name": venueLocation,
          "ST_DATE": formattedDateStart,
          "END_DATE": formattedDateEnd,
          "ST_TIME": formattedStartTime,
          "END_TIME": formattedEndTime,
          "online": online,
          "CAPACITY": 30.toString(),
          "PASSWORD": '123',
          "STATUS": status,
        },
        token: '55c8705b56499f311a6966ad60600d4c28b9f468');

    return BasicInfoFormData.fromJson(data);
  }
}


/*
18:
{
  "id": 0,
  "image": "string",
  "ID": 2147483647,
  "User_id": 2147483647,
  "Title": "string",
  "organizer": "string",
  "Summery": "string",
  "Description": "string",
  "type": "string",
  "category_name": "string",
  "sub_Category": "string",
  "venue_name": "string",
  "ST_DATE": "2023-04-14",
  "END_DATE": "2023-04-14",
  "ST_TIME": "string",
  "END_TIME": "string",
  "online": "s",
  "CAPACITY": 2147483647,
  "PASSWORD": "string",
  "STATUS": "string"
}


 String? eventTitle;
  String? type;
  String? category;
  String? venueLocation;
  DateTime? eventStart;
  DateTime? eventEnd;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  bool? display_start_time_Single;
  bool? display_end_time_Single;
  bool? display_end_time_Recurring;
  String? summary;
  String? eventDesc;
  File? eventImage;
  String? singleOrRecurring;
  String? organizer;
*/