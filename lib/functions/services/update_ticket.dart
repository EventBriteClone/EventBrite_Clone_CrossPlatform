import 'package:event_brite_app/models/basic_info_form.dart';
import 'package:event_brite_app/models/tickets_model.dart';
import 'package:event_brite_app/providers/creator/ticket_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/api.dart';
import '../../providers/creator/basic_info_provider.dart';
import '../../providers/token_provider.dart';

class UpdateTicketServices {
  Future<void> updateField({
    required int id,
    required String fieldName,
    required String newValue,
    required BuildContext context,
  }) async {
    String? token = Provider.of<TokenModel>(context).token;
    final TicketsModel =
        Provider.of<TicketProviderModel>(context, listen: false);

    Map<String, dynamic> data = await Api().putM(
      url:
          'https://event-us.me:8000/events/${TicketsModel.ticketID}/update_ticketclass/',
      body: {
        fieldName: newValue,
      },
      token:
          'CustomToken $token',
    );
    // return BasicInfoFormData.fromJson(data);
  }
}
