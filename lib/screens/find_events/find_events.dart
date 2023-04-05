// ignore_for_file: use_key_in_widget_constructors

import 'package:event_brite_app/screens/home_page/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'container_find_events.dart';

class FindEvents extends StatefulWidget {
  const FindEvents({key});

  @override
  State<FindEvents> createState() => _FindEventsState();
}

class _FindEventsState extends State<FindEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 28,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Find events in...',
                  hintStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.038,
              ),
              Row(
                children: [
                  ContainerFindEvents(
                    method: () async {
                      //var position = await determineLocation();
                      // print(position.elementAt(2).administrativeArea);
                      setState(
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomeScreen(
                                  selectedIndex: 1,
                                );
                              },
                            ),
                          );
                          ;
                        },
                      );
                    },
                    text: 'Nearby',
                    subText: 'Current location',
                    icon: FontAwesomeIcons.locationCrosshairs,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
