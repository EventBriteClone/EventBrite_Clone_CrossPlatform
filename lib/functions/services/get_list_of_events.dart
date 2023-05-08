import 'package:event_brite_app/helper/api.dart';
import 'package:event_brite_app/models/event_model.dart';

class Events {
  Future<List<EventModel>> getAllEvents() async {
    Map<String,dynamic> dataUnFiltered = await Api().get(
        url: 'https://event-us.me:8000/events/ALL/?page=1',
        token: 'CustomToken af2ae025cdc6bb4f7424909e533be0bdac61655418beae85cd689a16ee2b614b');
        //print(dataUnFiltered['results']);
       List<dynamic> data = (dataUnFiltered['results']);
  // print(data);
    List<EventModel> allEventsList = [];
    for (int i = 0; i < data.length; i++) {
      allEventsList.add(EventModel.fromJson(data[i]));
    }
    return allEventsList;
  }

  Future<List<EventModel>> getEventByCategory(String category) async {
    List<dynamic> dataUnFiltered = await Api().get(
        url: 'https://event-us.me:8000/events/category/$category/',
        token: 'CustomToken af2ae025cdc6bb4f7424909e533be0bdac61655418beae85cd689a16ee2b614b');
    //print(dataUnFiltered['results']);
    ///List<dynamic> data = (dataUnFiltered['results']);
    // print(data);
    List<EventModel> categorizedEvents = [];
    for (int i = 0; i < dataUnFiltered.length; i++) {
      categorizedEvents.add(EventModel.fromJson(dataUnFiltered[i]));
    }
    return categorizedEvents;
  }

  Future<List<EventModel>> getEventBySearch(String searchString) async {
    List<dynamic> dataUnFiltered = await Api().get(
        url: 'https://event-us.me:8000/events/search/$searchString/',
        token: 'CustomToken af2ae025cdc6bb4f7424909e533be0bdac61655418beae85cd689a16ee2b614b');
    //print(dataUnFiltered['results']);
    ///List<dynamic> data = (dataUnFiltered['results']);
    // print(data);
    List<EventModel> searchEvents = [];
    for (int i = 0; i < dataUnFiltered.length; i++) {
      searchEvents.add(EventModel.fromJson(dataUnFiltered[i]));
    }
    return searchEvents;
  }
}
