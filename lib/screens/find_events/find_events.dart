// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import '../search_screen.dart/search_screen.dart';
import 'container_find_events.dart';
import 'package:event_brite_app/services/geolocation.dart';

class FindEvents extends StatefulWidget {
  const FindEvents({key});

  @override
  State<FindEvents> createState() => _FindEventsState();
}

class _FindEventsState extends State<FindEvents> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
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
                    List<Placemark> position = await determineLocation();
                    // print(position.elementAt(2).administrativeArea);
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchScreen(position1: position,),
                        ),
                      );
                    });
                  },
                  text: 'Nearby',
                  subText: 'Current location',
                  icon: FontAwesomeIcons.locationCrosshairs,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.09,
                ),
                ContainerFindEvents(
                  method: () {},
                  text: 'Online events',
                  subText: 'Virtual attendance',
                  icon: Icons.ondemand_video_rounded,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
