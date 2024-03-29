import 'package:event_brite_app/models/sold_ticket_model.dart';
import 'package:event_brite_app/screens/event_dashboard_details/event_dashboard_details.dart';

import '../../helper/api.dart';
import '../../models/event_dashboard_details.dart';
import '../../models/event_model.dart';

class Dashboard {
  Future<List<SoldTicketModel>> getSoldTicketClasses() async {
    List<dynamic> dataUnFiltered = await Api().get(
        url:
            'https://event-us.me:8000/dashboard/eventmanagement/sold-tickets/4234/ticket-classes/',
        token:
            'CustomToken 3743b5ecba1461fcbf9ba874653ea8dc6792bd1a58ef656133dc71321f148332');
    //print(dataUnFiltered['results']);
    ///List<dynamic> data = (dataUnFiltered['results']);
    // print(data);
    List<SoldTicketModel> soldTicketClasses = [];
    for (int i = 0; i < dataUnFiltered.length; i++) {
      soldTicketClasses.add(SoldTicketModel.fromJson(dataUnFiltered[i]));
    }
    print(soldTicketClasses);
    return soldTicketClasses;
  }

  Future<List<EventModel>> getCreatorEvents() async {
    List<dynamic> data = await Api().get(
        url: 'https://event-us.me:8000/eventmanagement/creatorevents/',
        token:
            'CustomToken 3743b5ecba1461fcbf9ba874653ea8dc6792bd1a58ef656133dc71321f148332');
    //print(dataUnFiltered['results']);
    //List<dynamic> data = (dataUnFiltered['results']);
    // print(data);
    List<EventModel> allEventsList = [];
    for (int i = 0; i < data.length; i++) {
      allEventsList.add(EventModel.fromJson(data[i]));
    }
    return allEventsList;
  }


  Future<List<EventDashboardDetails>> getEventDashboardDetails (int eventId)async{
    List<dynamic> data = await Api().get(
        url: 'https://event-us.me:8000/dashboard/eventmanagement/sold-tickets/$eventId/ticket-classes/',
        token:
            'CustomToken 3743b5ecba1461fcbf9ba874653ea8dc6792bd1a58ef656133dc71321f148332');
    //print(dataUnFiltered['results']);
    //List<dynamic> data = (dataUnFiltered['results']);
    // print(data);
    List<EventDashboardDetails> eventDasshboardDetails = [];
    for (int i = 0; i < data.length; i++) {
      eventDasshboardDetails.add(EventDashboardDetails.fromJson(data[i]));
    }
    return eventDasshboardDetails;
  }
}
