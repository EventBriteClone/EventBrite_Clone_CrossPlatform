import '../../helper/api.dart';
import '../../models/event_model.dart';

class EventDetails 
{
  Future<EventModel> getEventDetails(int eventID) async {
    List<dynamic> dataIntitail = await Api().get(
        url: 'https://event-us.me:8000/events/ID/$eventID/',
        token: 'Basic a2FyZWVtc29iaGk1MEBnbWFpbC5jb206TmttbnJzMTIzIQ==');
    dynamic data = dataIntitail.elementAt(0);
    EventModel eventDetails = EventModel.fromJson(data);
    print(eventDetails);
    return eventDetails;
  }
}