import 'package:event_brite_app/helper/api.dart';
import 'package:event_brite_app/models/event_model.dart';

class Events {
  Future<List<EventModel>> getAllEvents() async {
    Map<String,dynamic> dataUnFiltered = await Api().get(
        url: 'https://event-us.me:8000/events/ALL/',
        token: 'Basic a2FyZWVtc29iaGk1MEBnbWFpbC5jb206TmttbnJzMTIzIQ==');
        //print(dataUnFiltered['results']);
       List<dynamic> data = (dataUnFiltered['results']);
  print(data);
    List<EventModel> allEventsList = [];
    for (int i = 0; i < data.length; i++) {
      allEventsList.add(EventModel.fromJson(data[i]));
    }
    return allEventsList;
  }
}
