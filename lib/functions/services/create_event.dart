import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../../helper/api.dart';
import '../../models/basic_info_form.dart';

//when we create event we want to save the event id

/// Creates an event with the provided parameters.
///
/// - Title (String)
/// - type (String)
/// - category_name (String)
/// - venue_name (String)
/// - ST_DATE (String)
/// - END_DATE (String)
/// - ST_TIME (String)
/// - END_TIME (String)
/// - Summery (String)
/// - Description (String)
/// - online (String)
/// - STATUS (String)
/// - CAPACITY (int)
///

class CreateEventService {
  /// Parameters:
  /// - [eventTitle] (String?) - Title of the event.
  /// - [type] (String?) - Type of the event.
  /// - [category] (String?) - Category of the event.
  /// - [venueLocation] (String?) - Venue location of the event.
  /// - [eventStart] (DateTime?) - Start date and time of the event.
  /// - [eventEnd] (DateTime?) - End date and time of the event.
  /// - [startTime] (TimeOfDay?) - Start time of the event.
  /// - [endTime] (TimeOfDay?) - End time of the event.
  /// - [summary] (String?) - Summary of the event.
  /// - [eventDesc] (String?) - Description of the event.
  /// - [eventImage] (File?) - Image of the event.
  /// - [organizer] (String?) - Organizer of the event.
  /// - [status] (String?) - Status of the event.
  /// - [online] (String?) - "True" or "False" depending on whether the event is online or not.
  /// - [display_start_time_Single] (bool?) - Whether to display the start time for a single event.
  /// - [display_end_time_Single] (bool?) - Whether to display the end time for a single event.
  /// - [display_end_time_Recurring] (bool?) - Whether to display the end time for a recurring event.
  /// - [singleOrRecurring] (String?) - "Single" or "Recurring" depending on the event type.
  /// - [sub_Category] (String?) - Sub-category of the event.
  /// - [CAPACITY] (int?) - Capacity of the event.
  ///
  /// Returns a [Future] that completes with a [Map] containing the event ID and response data and uses [postWithFile] from [Api]
  ///

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
    // required int? User_id,
    required String? sub_Category,
    required int? CAPACITY,
    // required String? PASSWORD,
  }) async {
// Format the start and end dates as dd/mm/yyyy
    print(eventStart);
    String formattedDateStart = DateFormat('yyyy-MM-dd').format(eventStart!);
    String formattedDateEnd = DateFormat('yyyy-MM-dd').format(eventEnd!);

    print(formattedDateEnd);
    print(formattedDateStart);

// Format the start and end times as --:-- --
    String formattedStartTime = DateFormat('hh:mm:ss')
        .format(DateTime(1, 1, 1, startTime!.hour, startTime.minute));
    String formattedEndTime = DateFormat('hh:mm:ss')
        .format(DateTime(1, 1, 1, endTime!.hour, endTime.minute));

    // print(
    //     "https://127.0.0.1:8000/media/events/${eventImage!.path.split('/').last}");

    final response = await Api().postWithFile(
      url: 'https://event-us.me:8000/events/create/',
      body: {
        //'ID': 2110480642.toString(),
        //'User_id': 2110480640.toString(),
        'Title': eventTitle,
        'organizer': organizer,
        'Summery': summary,
        'Description': eventDesc,
        'type': type,
        'category_name': category,
        'sub_Category': "bla",
        'venue_name': venueLocation,
        'ST_DATE': formattedDateStart,
        'END_DATE': formattedDateEnd,
        'ST_TIME': formattedStartTime,
        'END_TIME': formattedEndTime,
        'online': online,
        'CAPACITY': 30.toString(),
        //'PASSWORD': "123",
        'STATUS': status,
      },
      file: eventImage,
      token:
          'CustomToken af2ae025cdc6bb4f7424909e533be0bdac61655418beae85cd689a16ee2b614b',
      //CustomToken af2ae025cdc6bb4f7424909e533be0bdac61655418beae85cd689a16ee2b614b
      //Basic a2FyZWVtc29iaGk1MEBnbWFpbC5jb206TmttbnJzMTIzIQ==
    );

    final responseData = response['response'];
    final eventId = responseData['ID'];

    //return BasicInfoFormData.fromJson(response);
    return {
      'ID': eventId,
      'response': BasicInfoFormData.fromJson(responseData)
    };

    //return BasicInfoFormData.fromJson(data);
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