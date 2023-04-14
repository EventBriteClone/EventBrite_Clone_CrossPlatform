import 'package:event_brite_app/functions/services/get_event_details.dart';
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
            //print(eventDetails);
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.025),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/Eventbrite_logo.png',
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                  Text(
                    'Magna Carta: Beyond 1215',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                    ),
                  )
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
