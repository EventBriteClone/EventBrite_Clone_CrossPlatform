import 'dart:convert';
import 'dart:io';
import 'package:event_brite_app/models/promocode_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../../helper/api.dart';
import '../../models/basic_info_form.dart';

/// class for [CreatePromoCodeService] to  [createPromoCode]
///

class CreatePromoCodeService {
  /// [codeName] is the name of the promo code.
  /// [limitedOrUn] indicates whether the promo code has a limited quantity or unlimited quantity.
  /// [limitAmount] is the maximum number of tickets that can be purchased with this promo code.
  /// [revealHidden] indicates whether the promo code will be revealed to the attendees or not.
  /// [discountPrice] is the price reduction that will be applied to the tickets.
  /// [discountAmount] is the percentage reduction that will be applied to the tickets.
  /// [starts] is the start time of the promo code.
  /// [ends] is the end time of the promo code.
  /// [codeStart] is the start date of the promo code.
  /// [codeEnd] is the end date of the promo code.
  /// [startTime] is the start time of the promo code.
  /// [endTime] is the end time of the promo code.
  /// [quantityAvailable] is the number of promo codes that are available for use.
  /// [csvFile] is a CSV file containing the promo codes.
  /// Returns a [Map] with the promo code ID and the promo code response using [postWithFile] from [Api]
  Future<dynamic> createPromoCode({
    required String? codeName,
    required String? limitedOrUn,
    required int? limitAmount,
    required String? revealHidden,
    required double? discountPrice,
    required int? discountAmount,
    required String? starts,
    required String? ends,
    required DateTime? codeStart,
    required DateTime? codeEnd,
    required TimeOfDay? startTime,
    required TimeOfDay? endTime,
    required int? quantityAvailable,
    required File? csvFile,
  }) async {
// Format the start and end dates as dd/mm/yyyy

    String formattedDateStart = DateFormat('yyyy-MM-dd').format(codeStart!);
    String formattedDateEnd = DateFormat('yyyy-MM-dd').format(codeEnd!);

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
        'CODE': codeName,
        'Ticket_limit': limitedOrUn,
        'Limitedamount': limitAmount,
        'Reveal_hidden': revealHidden,
        'Discountـpercentage': discountAmount,
        'Discount_price': discountPrice,
        'Starts': starts,
        'Ends': ends,
        'start_date': formattedDateStart,
        'start_time': formattedStartTime,
        'end_date': formattedDateEnd,
        'end_time': formattedEndTime,
        'Quantity_available': quantityAvailable,
      },
      file: csvFile,
      token:
          'CustomToken af2ae025cdc6bb4f7424909e533be0bdac61655418beae85cd689a16ee2b614b',
    );

    final responseData = response['response'];
    final id = responseData['ID'];

    return {'ID': id, 'response': PromoCodeModel.fromJson(responseData)};

    //return BasicInfoFormData.fromJson(data);
  }
}
