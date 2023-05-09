import 'package:event_brite_app/models/tickets_model.dart';
import 'package:event_brite_app/screens/creator/basic_info/tickets/add_ticket.dart';
import 'package:event_brite_app/screens/creator/basic_info/tickets/tickets_info_input.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/basic_info_form.dart';
import '../../models/event_model.dart';
import '../../screens/creator/create_event/add_event_p_one.dart';

///This is a [AdmissionComponent] widget that displays tickets of that specefic event
///It shows the ticket data using [TicketsModel] object called [ticket] which represents the ticket model.
///[ticket] is input parameter to the widget
///It also checks the [salesStart], [salesEnd],[startTime], [endTime] and compares them with [DateTime] of now in order to determine if the ticket sale has ended, scheduled or still on Sale and change the colors accordingly
///we also have a [editDeleteView]. The [editDeleteView] function displays a modal bottom sheet that allows the user to edit or delete the ticket object, or to view its  info

class AdmissionComponent extends StatelessWidget {
  final TicketsModel ticket;

  const AdmissionComponent({Key? key, required this.ticket}) : super(key: key);

  @override
  Key? get key => super.key;

  @override
  Widget build(BuildContext context) {
    //we want capacity, price, end date, end time  & name
    //we will see if onsale green
    //if one day left blue
    //if sold red

    String? ticketName = ticket.ticketName;
    double? price = ticket.price;
    int? capacity = ticket.capacity;
    DateTime? salesEnd = ticket.salesEnd;
    TimeOfDay? endTime = ticket.endTime;
    DateTime? salesStart = ticket.salesStart;
    TimeOfDay? startTime = ticket.startTime;

    final formattedEndDate = DateFormat('MMM d, y').format(salesEnd!);

    final formattedStartDate = DateFormat('MMM d, y').format(salesStart!);

    final formattedEndTime = DateFormat.jm()
        .format(DateTime(1, 1, 1, endTime!.hour, endTime.minute));

    final formattedStartTime = DateFormat.jm()
        .format(DateTime(1, 1, 1, startTime!.hour, startTime.minute));

    DateTime dateNow = DateTime.now();
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));

    //we want to check  to change color:
    //we have green on sale end date [start date <= datenow] & [end date > datetime now]
    //we have yellow scheduled start date [start date > datenow]
    //we have blue on sale end date [end date > datetimenow with 1 day only]
    //we have green sale end end date [end date < datetime now]

    // on sale, scheduled, on sale , end
    //          starttime            today        endtime
    String? colorString;
    bool? onSale = false;
    bool? scheduled = false;
    bool? ended = false;
    bool? soon = false;

    if (salesStart.isBefore(dateNow)) {
      //start date is before then check on end time 3 conditions, passed, not yet, 1 day left
      if (salesEnd.isBefore(dateNow)) {
        // End date is before now "ended"
        ended = true;
        colorString = "grey";
      }
      //check if date is after or equal 2day
      else if ((salesEnd.isAfter(dateNow) ||
          (salesEnd.year == dateNow.year &&
              salesEnd.month == dateNow.month &&
              salesEnd.day == dateNow.day))) {
        //if same day or after by 1 day only or today
        if ((salesEnd.year == tomorrow.year &&
                salesEnd.month == tomorrow.month &&
                salesEnd.day == tomorrow.day) ||
            (salesEnd.year == dateNow.year &&
                salesEnd.month == dateNow.month &&
                salesEnd.day == dateNow.day)) {
          soon = true;
          colorString = "blue";
        } else {
          //havent ended yet
          onSale = true;
          colorString = "green";
        }
      }
    } else {
      scheduled = true;
      colorString = "yellow";
    }

    //to get par:
    String? ticketType = ticket.ticketType;
    int par;
    if (ticketType == "Free") {
      par = 0;
    } else {
      par = 1;
    }

    return Expanded(
      key: key,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom:
                      BorderSide(color: Color.fromARGB(122, 158, 158, 158)))),
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/ticketslisticon.png"),
                  Text(
                    ticketName ?? '',
                    // event.title!,
                    //  'General Admission',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                        fontFamily: "Neue Plak Extended SemiBold",
                        color: Color.fromARGB(255, 55, 55, 55)),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  GestureDetector(
                    key: ValueKey("editdeleteviewticket"),
                    onTap: () {
                      editDeleteView(context, par, ticket);
                    },
                    child: Image.asset("assets/images/dot.png"),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    !ended
                        ? Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              //color: Colors.green,
                              color: onSale
                                  ? Colors.green
                                  : (soon
                                      ? Colors.blue
                                      : (scheduled
                                          ? Colors.yellow
                                          : Color.fromARGB(219, 77, 77, 77))),
                            ),
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                    !ended
                        ? const SizedBox(
                            width: 2,
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                    Text(
                      onSale
                          ? 'On Sale '
                          : (soon ? 'On Sale' : (scheduled ? 'Scheduled' : '')),
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Neue Plak Extended SemiBold",
                        color: Color.fromARGB(219, 77, 77, 77),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 92, 92, 92),
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      onSale
                          ? 'Ends ${formattedEndDate} at ${formattedEndTime} '
                          : (soon
                              ? 'Ends ${formattedEndDate} at ${formattedEndTime}'
                              : (scheduled
                                  ? 'Starts ${formattedStartDate} at ${formattedStartTime}'
                                  : 'Ended ${formattedEndDate} at ${formattedEndTime}')),
                      // 'Ends ${formattedEndDate} at ${formattedEndTime}',
                      //' Ends May 27, 2023 at 7:00 Am',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Neue Plak Extended SemiBold",
                        color: Color.fromARGB(219, 77, 77, 77),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 80, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "0/${capacity}",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Neue Plak Extended SemiBold",
                        color: Color.fromARGB(219, 77, 77, 77),
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Text(
                      "\$${price}",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Neue Plak Extended SemiBold",
                        color: Color.fromARGB(219, 77, 77, 77),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<dynamic> editDeleteView(
    BuildContext context, int par, TicketsModel ticket) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.18,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          AddTickets(par: par, previousTicketModel: ticket)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.remove_circle_outline),
              title: Text('Delete'),
              onTap: () {
                // Delete the event here
                //Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}
