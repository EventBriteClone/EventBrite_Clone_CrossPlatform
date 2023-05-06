import 'package:event_brite_app/screens/find_events/find_events.dart';
import 'package:event_brite_app/functions/services/geolocation.dart';
import 'package:event_brite_app/screens/searched_events/searched_events.dart';
import 'package:flutter/material.dart';
import '../../reusable_widgets/custom_loading_indicator.dart';
import '../../reusable_widgets/event_item.dart';
import '../event_details_screen/event_details_screen.dart';
import 'category_container.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late String position;

  Future<String> getPosition() async {
    position = await determineLocation();
    return position;
  }

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: getPosition(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const FindEvents();
                            },
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            position,
                            style: const TextStyle(fontSize: 19),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down_rounded,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.007,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: myController,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Start searching...',
                              hintStyle: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if
                              (myController.text != ''){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SearchedEvents(
                                      searchString: myController.text);
                                },
                              ),
                            );
                            } else
                            {
                              const snackBar = SnackBar(content: Text('Please enter a valid value'),);
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          },
                          icon: const Icon(
                            Icons.search,
                            size: 28,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.024,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          CategoryContainer(text: 'Food & Drink'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                          CategoryContainer(text: 'Health & Wellness'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                          CategoryContainer(text: 'Charity & Causes'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                          CategoryContainer(text: 'Family & Education'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                          CategoryContainer(text: 'Fashion & Beauty'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                          CategoryContainer(text: 'Music'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                          CategoryContainer(text: 'Home & Lifestyle'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                          CategoryContainer(text: 'Sports & Fitness'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                          CategoryContainer(text: 'Travel & Outdoor'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                          CategoryContainer(text: 'Other'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.085,
                    ),
                    // Expanded(
                    //   child: ListView.builder(
                    //     itemCount: listLength, // will be changed later
                    //     itemBuilder: (context, index) {
                    //       //print(ID);
                    //       String? stDate = events.elementAt(index).stDate;
                    //       String? endDate = events.elementAt(index).endDate;
                    //       String? stTime = events.elementAt(index).stTime;
                    //       String? title = events.elementAt(index).title;
                    //       String? venueName = events.elementAt(index).venueName;
                    //       int? ID = events.elementAt(index).ID;
                    //       String? imageURL = events.elementAt(index).image;
                    //       return GestureDetector(
                    //         onTap: () {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (context) => EventDetailsScreen(
                    //                 iD: ID,
                    //               ),
                    //             ),
                    //           );
                    //         },
                    //         child: EventItem(
                    //           stDate: stDate,
                    //           endDate: endDate,
                    //           stTime: stTime,
                    //           title: title,
                    //           venue: venueName,
                    //           ID: ID,
                    //           imageURL: imageURL,
                    //         ),
                    //       ); // custom widget
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          }
          return const CustomLoadingIndicator();
        },
      ),
    );
  }
}
