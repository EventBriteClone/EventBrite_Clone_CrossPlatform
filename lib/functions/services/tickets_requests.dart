import 'package:event_brite_app/models/ticket_model.dart';

import '../../helper/api.dart';

class Tickets {
  Future<List<TicketModel>> getTicketClasses() async {
    List<dynamic> dataUnFiltered = await Api().get(
        url: 'https://event-us.me:8000/booking/events/1854/ticket-classes/',
        token:
            'CustomToken 6cf8d331b4ec9aaba7d5d4ae8a9330e4eb0e1cc52b9173a2a53c111f507b69ad');
    List<TicketModel> tickets = [];
    for (int i = 0; i < dataUnFiltered.length; i++) {
      tickets.add(TicketModel.fromJson(dataUnFiltered[i]));
    }
    return tickets;
  }
}