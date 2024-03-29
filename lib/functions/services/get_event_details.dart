import '../../helper/api.dart';
import '../../models/event_model.dart';

class EventDetails {
  Future<EventModel> getEventDetails(int eventID) async {
    List<dynamic> dataIntitail = await Api().get(
        url: 'https://event-us.me:8000/events/ID/$eventID/',
        token:
            'CustomToken af2ae025cdc6bb4f7424909e533be0bdac61655418beae85cd689a16ee2b614b');
    // Map<String, dynamic> ticketPriceUnFiltered = await Api().get(
    //     url: 'https://event-us.me:8000/events/TicketsPrice/$eventID/',
    //     token:
    //         'CustomToken daf51769d5c801e9ef6e2739add62e64c6b294406287bbd8c144b352284b5695');
    // dataIntitail.add(ticketPriceUnFiltered);
    // dynamic ticketsPrice = dataIntitail.elementAt(1);
    Map<String, dynamic> data = dataIntitail.elementAt(0);
    // data.addAll(ticketsPrice);
    EventModel eventDetails = EventModel.fromJson(data);
    //print(data);
   return eventDetails;
  }
}
