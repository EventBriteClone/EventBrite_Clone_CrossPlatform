import '../../helper/api.dart';
import '../../models/event_model.dart';

class EventDetails {
  Future<EventModel> getEventDetails(int eventID) async {
    List<dynamic> dataIntitail = await Api().get(
        url: 'https://event-us.me:8000/events/ID/$eventID/',
        token: 'Basic a2FyZWVtc29iaGk1MEBnbWFpbC5jb206TmttbnJzMTIzIQ==');
        Map<String, dynamic> ticketPriceUnFiltered = await Api().get(
        url: 'https://event-us.me:8000/events/TicketsPrice/$eventID/',
        token: 'Basic a2FyZWVtc29iaGk1MEBnbWFpbC5jb206TmttbnJzMTIzIQ==');
    dataIntitail.add(ticketPriceUnFiltered);
    dynamic ticketsPrice = dataIntitail.elementAt(1);
    Map<String,dynamic> data = dataIntitail.elementAt(0);
    data.addAll(ticketsPrice);
    EventModel eventDetails = EventModel.fromJson(data);
    //print(data);
    //print(eventDetails);
    return eventDetails;
  }
}
