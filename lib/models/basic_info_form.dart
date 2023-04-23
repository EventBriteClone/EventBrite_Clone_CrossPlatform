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
  });

  factory BasicInfoFormData.fromJson(jsonData) {
    return BasicInfoFormData(
        // eventTitle:jsonData['id'],
        // type: jsonData['title'],
        // category: jsonData['category'],
        // category: jsonData['price'],
        // description: jsonData['description'],
        // image: jsonData['image'],
        // rating: jsonData['rating'] == null
        //     ? null
        //     : RatingModel.fromJson(jsonData['rating']
        );
  }
}
