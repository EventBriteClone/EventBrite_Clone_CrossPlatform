import 'package:event_brite_app/screens/find_events/find_events.dart';
import 'package:event_brite_app/functions/services/geolocation.dart';
import 'package:flutter/material.dart';
import '../../reusable_widgets/custom_loading_indicator.dart';
import '../../reusable_widgets/event_item.dart';
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
                    const TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Start searching...',
                        hintStyle: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.024,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          CategoryContainer(text: 'All'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                          CategoryContainer(text: 'Online'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                          CategoryContainer(text: 'Today'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                          CategoryContainer(text: 'This weekend'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                          CategoryContainer(text: 'Free'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                          CategoryContainer(text: 'Music'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                          CategoryContainer(text: 'Food & Drink'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                          CategoryContainer(text: 'Charity & Causes'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.085,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 5, // will be changed later
                        itemBuilder: (context, index) {
                          return const EventItem(); // custom widget
                        },
                      ),
                    ),
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
