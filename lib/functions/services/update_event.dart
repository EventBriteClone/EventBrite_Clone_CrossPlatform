import 'package:event_brite_app/models/basic_info_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/api.dart';
import '../../providers/creator/basic_info_provider.dart';
import '../../providers/token_provider.dart';

class UpdateEventServices {
  Future<void> updateField({
    required int id,
    required String fieldName,
    required String newValue,
    required BuildContext context,
  }) async {
    String? token = Provider.of<TokenModel>(context).token;
    final eventModel =
        Provider.of<BasicInfoFormDataProvider>(context, listen: false);

    Map<String, dynamic> data = await Api().putM(
      url:
          'https://event-us.me:8000/events/${eventModel.eventId}/update_event/',
      body: {
        fieldName: newValue,
      },
      token:
          'CustomToken $token',
    );
    // return BasicInfoFormData.fromJson(data);
  }
}
