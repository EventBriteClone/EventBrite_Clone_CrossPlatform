import 'dart:io';

import 'package:flutter/material.dart';

/// Here we save the data from the Basic Info that the user enters
/// we have [eventTitle] , [type], [category], [venueLocation], [eventStart], [eventEnd], [startTime], [endTime] representing data gotten from the first page the user enter
/// And we have 3 checkboxes, 2 for single event and 1 for recurring event: [display_start_time_Single], [display_end_time_Single], [display_end_time_Recurring]
/// we also have [eventImage], [summary], [eventDesc]
/// we also have [singleOrRecurring] to check which one user picked
/// we have [organzier]
/// [status] indicates whether event is draft , live or past
/// [online] indicates whether event is online or not
class BasicInfoFormData {
  int? eventID;
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
  String? status;
  String? online;

  BasicInfoFormData({
    this.eventTitle,
    this.type,
    this.category,
    this.venueLocation,
    this.eventStart,
    this.eventEnd,
    this.startTime,
    this.endTime,
    this.display_end_time_Single,
    this.display_start_time_Single,
    this.display_end_time_Recurring,
    this.summary,
    this.eventDesc,
    this.eventImage,
    this.singleOrRecurring,
    this.organizer,
    this.online,
    this.status,
    this.eventID,
  });

  factory BasicInfoFormData.fromJson(jsonData) {
    return BasicInfoFormData(
      eventID: jsonData['ID'],
      eventTitle: jsonData['Title'],
      type: jsonData['type'],
      category: jsonData['category_name'],
      venueLocation: jsonData['venue_name'],
      eventStart: DateTime.parse(jsonData['ST_DATE']),
      eventEnd: DateTime.parse(jsonData['END_DATE']),

      startTime: TimeOfDay.fromDateTime(
          DateTime.parse('1970-01-01 ${jsonData['ST_TIME']}')),
      endTime: TimeOfDay.fromDateTime(
          DateTime.parse('1970-01-01 ${jsonData['END_TIME']}')),
      summary: jsonData['Summery'],
      eventDesc: jsonData['Description'],
      organizer: jsonData['organizer'],
      status: jsonData['STATUS'],
      online: jsonData['online'],
      // id: json['id'] as int?,
      // 	image: json['image'] as String?,
      // 	subCategory: json['sub_Category'] as String?,
      // 	capacity: json['CAPACITY'] as int?,
      //   ticketPrice: json['ticket_price'] as double?,
      // display_start_time_Single: jsonData['display_start_time_Single'],
// display_end_time_Single: jsonData['display_end_time_Single'],
// display_end_time_Recurring: jsonData['display_end_time_Recurring'],
      //   eventImage: File(jsonData['image']),
// singleOrRecurring: jsonData['singleOrRecurring'],

      // 	password: json['PASSWORD'] as String?,

      // 	userId: json['User_id'] as int?,
    );
  }
}
