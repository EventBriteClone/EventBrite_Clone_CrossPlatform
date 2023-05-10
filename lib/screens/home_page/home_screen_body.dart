// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import '../../functions/services/get_list_of_events.dart';
import '../../models/event_model.dart';
import '../../reusable_widgets/event_item.dart';
import 'package:event_brite_app/reusable_widgets/custom_loading_indicator.dart';

import '../event_details_screen/event_details_screen.dart';
import 'package:event_brite_app/reusable_widgets/custom_loading_indicator.dart';

import '../event_details_screen/event_details_screen.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EventModel>>(
      future: Events().getAllEventsBody(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<EventModel> events = snapshot.data!;
          int? listLength = events.length;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 32,
                    left: 7,
                    right: 7,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Related to your orders',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: listLength, // will be changed later
                          itemBuilder: (context, index) {
                            //print(ID);
                            String? stDate = events.elementAt(index).stDate;
                            String? endDate = events.elementAt(index).endDate;
                            String? stTime = events.elementAt(index).stTime;
                            String? title = events.elementAt(index).title;
                            String? venueName =
                                events.elementAt(index).venueName;
                            int? ID = events.elementAt(index).ID;
                            String? imageURL = events.elementAt(index).image;
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EventDetailsScreen(
                                      iD: ID,
                                    ),
                                  ),
                                );
                              },
                              child: EventItem(
                                stDate: stDate,
                                endDate: endDate,
                                stTime: stTime,
                                title: title,
                                venue: venueName,
                                ID: ID,
                                imageURL: imageURL,
                              ),
                            ); // custom widget
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(child: CustomLoadingIndicator());
        }
      },
    );
  }
}
