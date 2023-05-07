import 'package:event_brite_app/models/ticket_model.dart';

import '../../helper/api.dart';

class Tickets {
  Future<List<TicketModel>> getTicketClasses() async {
    List<dynamic> dataUnFiltered = await Api().get(
        url: 'https://event-us.me:8000/booking/events/945/ticket-classes/',
        token:
            'CustomToken 65e1180796caf66355282edfae231cf52353ee8591a6efa8aa98d6ef76856a0c');
    List<TicketModel> tickets = [];
    for (int i = 0; i < dataUnFiltered.length; i++) {
      tickets.add(TicketModel.fromJson(dataUnFiltered[i]));
    }
    return tickets;
  }
}