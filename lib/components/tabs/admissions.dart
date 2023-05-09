import 'package:event_brite_app/functions/services/get_tickets.dart';
import 'package:event_brite_app/models/tickets_model.dart';
import 'package:flutter/material.dart';

import '../../functions/services/get_draft_events.dart';
import '../../models/event_model.dart';
import '../tickets_info/admission_component.dart';

/// A tab that displays a list of tickets . It fetches the data asynchronously using [AllTicketsServices]
/// and shows a loading indicator while waiting for the data. If there are no tickets available, it displays a [NoComponentWidget]
///  Otherwise, it shows a [ListView] with a [AdmissionComponent] for each ticket

class AdmissionsTab extends StatelessWidget {
  const AdmissionsTab({super.key});

  //final TicketsModel ticketdata;
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: AdmissionComponent(ticket: ticketdata,),

    // );
    return FutureBuilder<List<TicketsModel>>(
      future: AllTicketsServices().getAllTickets(context),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching draft events'));
        }
        final ticketList = snapshot.data ?? [];
        final noTickets = ticketList.isEmpty;
        return Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: ListView.builder(
            itemCount: ticketList.length,
            itemBuilder: (context, index) {
              final TicketsModel ticket = ticketList[index];
              print(ticketList[index]);
              // print(event.category);
              return AdmissionComponent(
                ticket: ticket,
              );
            },
          ),
        );
      },
    );
  }
}
