import 'package:event_brite_app/functions/services/get_list_of_events.dart';
import 'package:event_brite_app/reusable_widgets/custom_loading_indicator.dart';
import 'package:event_brite_app/screens/home_page/home_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../models/event_model.dart';
import '../../reusable_widgets/event_item.dart';
import '../event_details_screen/event_details_screen.dart';
import '../home_page/home_screen.dart';

class SearchedEvents extends StatefulWidget {
  const SearchedEvents({super.key, required this.searchString});
  final String searchString;

  @override
  State<SearchedEvents> createState() => _SearchedEventsState();
}

class _SearchedEventsState extends State<SearchedEvents> {
  @override
  Widget build(BuildContext context) {
    ///print(widget.searchString);
    return Scaffold(
      body: FutureBuilder(
        future: Events().getEventBySearch(widget.searchString, context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<EventModel> events = snapshot.data!;
            if (events.isEmpty) {
              //print(events);
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.018,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(
                                    selectedIndex: 1,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 28,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.045,
                          ),
                          Text(
                            'Results for: ${widget.searchString}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.357,
                      ),
                      const Center(
                        child: Text(
                          'No Events found!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            ///print(events);
            else {
              print(events);
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.018,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(
                                    selectedIndex: 1,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 28,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.045,
                          ),
                          Text(
                            'Results for: ${widget.searchString}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.035,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: events.length, // will be changed later
                          itemBuilder: (context, index) {
                            //print(ID);
                            String? stDate = events.elementAt(index).stDate;
                            String? endDate = events.elementAt(index).endDate;
                            String? stTime = events.elementAt(index).stTime;
                            String? title = events.elementAt(index).title;
                            String? venueName =
                                events.elementAt(index).venueName;
                            int? ID = events.elementAt(index).ID;
                            String? imageURL =
                                events.elementAt(index).image?.substring(24);
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
              );
            }
          }
          return const CustomLoadingIndicator();
        },
      ),
    );
  }
}
