import 'package:event_brite_app/helper/api.dart';
import 'package:event_brite_app/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/token_provider.dart';

class Events {
  Future<List<EventModel>> getAllEvents(BuildContext context) async {
    String? token = Provider.of<TokenModel>(context).token;
    Map<String,dynamic> dataUnFiltered = await Api().get(
        url: 'https://event-us.me:8000/events/ALL/',
        token: 'Basic $token');
        //print(dataUnFiltered['results']);
       List<dynamic> data = (dataUnFiltered['results']);
  // print(data);
    List<EventModel> allEventsList = [];
    for (int i = 0; i < data.length; i++) {
      allEventsList.add(EventModel.fromJson(data[i]));
    }
    return allEventsList;
  }
}
