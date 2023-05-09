import 'package:event_brite_app/models/basic_info_form.dart';
import 'package:event_brite_app/models/tickets_model.dart';
import 'package:event_brite_app/providers/creator/ticket_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/api.dart';
import '../../providers/creator/basic_info_provider.dart';

class UpdateTicketServices {
  Future<void> updateField({
    required int id,
    required String fieldName,
    required String newValue,
    required BuildContext context,
  }) async {
    final TicketsModel =
        Provider.of<TicketProviderModel>(context, listen: false);

    Map<String, dynamic> data = await Api().putM(
      url:
          'https://event-us.me:8000/events/${TicketsModel.ticketID}/update_ticketclass/',
      body: {
        fieldName: newValue,
      },
      token:
          'CustomToken af2ae025cdc6bb4f7424909e533be0bdac61655418beae85cd689a16ee2b614b',
    );
    // return BasicInfoFormData.fromJson(data);
  }
}
