import 'package:event_brite_app/functions/services/get_event_details.dart';
import 'package:event_brite_app/screens/tickets_screen/tickets_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';
import '../../models/event_model.dart';
import '../../reusable_widgets/custom_loading_indicator.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key, this.iD});

  final int? iD;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.heart,
              size: 18,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_outlined),
          ),
        ],
      ),
      body: FutureBuilder<dynamic>(
        future: EventDetails().getEventDetails(iD!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            EventModel eventDetails = snapshot.data!;
            String? title = eventDetails.title;
            int? eventId = eventDetails.ID;
            String? description = eventDetails.summery;
            String? stDate = eventDetails.stDate;
            String? stTime = eventDetails.stTime;
            String? online = eventDetails.online;
            double? ticketPrice = eventDetails.ticketPrice;
            String? venueName = eventDetails.venueName;
            String? imageURl = eventDetails.image;
            String? organizer = eventDetails.organizer;
            String CheckOnlineStatus() {
              if (online == 'False') {
                return venueName!;
              } else {
                return 'Online';
              }
            }

            //print(eventDetails);
            String? functionReturn = CheckOnlineStatus();
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Image.asset(
                          'assets/images/Eventbrite_logo.png',
                          // Image.network(
                          //   imageURl!,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.35,
                        ),
                        Text(
                          title!,
                          style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Neue Plak'),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Text(
                          'Organized by: $organizer',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        EventDetailsRow(
                          data: stDate,
                          dataNotRequired: '',
                          icon: Icons.calendar_today,
                        ),
                        EventDetailsRow(
                          data: functionReturn,
                          icon: Icons.slideshow,
                          dataNotRequired: '',
                        ),
                        EventDetailsRow(
                          data: 'Duration: $stTime',
                          icon: Icons.access_time,
                          dataNotRequired: '',
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        const Text(
                          'About',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Text(
                          description!,
                          style: const TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return TicketsScreen(
                                eventId: eventId,
                                eventName: title,
                              );
                            },
                          ),
                        );
                      },
                      child: const Text(
                        'Tickets',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.007,
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CustomLoadingIndicator());
          }
        },
      ),
    );
  }
}

class EventDetailsRow extends StatelessWidget {
  const EventDetailsRow({
    super.key,
    required this.data,
    this.dataNotRequired,
    required this.icon,
  });

  final String? data;
  final String? dataNotRequired;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 19,
          color: Colors.grey,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.08,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data!,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.008,
            ),
            Text(
              dataNotRequired!,
              style: TextStyle(fontSize: 14),
            )
          ],
        )
      ],
    );
  }
}
