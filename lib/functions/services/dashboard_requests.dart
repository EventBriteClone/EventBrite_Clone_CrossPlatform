import 'package:event_brite_app/models/order_items_get_model.dart';
import 'package:event_brite_app/models/sold_ticket_model.dart';
import 'package:event_brite_app/screens/event_dashboard_details/event_dashboard_details.dart';

import '../../helper/api.dart';
import '../../models/event_dashboard_details.dart';
import '../../models/event_model.dart';

class Dashboard {
  Future<List<SoldTicketModel>> getSoldTicketClasses(dynamic token) async {
    List<dynamic> dataUnFiltered = await Api().get(
        url:
            'https://event-us.me:8000/dashboard/eventmanagement/sold-tickets/4234/ticket-classes/',
        token:
            'CustomToken $token');
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

  Future<List<EventModel>> getCreatorEvents(dynamic token) async {
    List<dynamic> data = await Api().get(
        url: 'https://event-us.me:8000/eventmanagement/creatorevents/',
        token:
            'CustomToken $token');
    //print(dataUnFiltered['results']);
    //List<dynamic> data = (dataUnFiltered['results']);
    // print(data);
    List<EventModel> allEventsList = [];
    for (int i = 0; i < data.length; i++) {
      allEventsList.add(EventModel.fromJson(data[i]));
    }
    return allEventsList;
  }

  Future<List<EventDashboardDetails>> getEventDashboardDetails(
      int eventId, dynamic token) async {
    List<dynamic> data = await Api().get(
        url:
            'https://event-us.me:8000/dashboard/eventmanagement/sold-tickets/$eventId/ticket-classes/',
        token:
            'CustomToken $token');
    //print(dataUnFiltered['results']);
    //List<dynamic> data = (dataUnFiltered['results']);
    // print(data);
    List<EventDashboardDetails> eventDasshboardDetails = [];
    for (int i = 0; i < data.length; i++) {
      eventDasshboardDetails.add(EventDashboardDetails.fromJson(data[i]));
    }
    return eventDasshboardDetails;
  }

  Future<List<OrderItemsGetModel>> getMyorders(eventId, dynamic token) async {
    Map<String, dynamic> data = await Api().get(
        url:
            "https://event-us.me:8000/dashboard/eventmanagement/event/$eventId/order-items/",
        token: "CustomToken $token");
    List<OrderItemsGetModel> eventDasshboardDetails = [];
    for (int i = 0; i < data.length; i++) {
      eventDasshboardDetails.add(OrderItemsGetModel.fromJson(data["data"][i]));
    }
    return eventDasshboardDetails;
  }
}
