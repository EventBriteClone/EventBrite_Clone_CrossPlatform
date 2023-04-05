// ignore_for_file: use_key_in_widget_constructors

import 'package:event_brite_app/screens/event_screen/event_screen.dart';
import 'package:event_brite_app/screens/event_details_screen/event_details_screen.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'followers_and_icons_row.dart';

class EventItem extends StatelessWidget {
  const EventItem({key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const EventScreen();
            },
          ),
        );
      },
      child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EventDetailsScreen(),
          ),
        );
      },
      child: Container(
          decoration: const BoxDecoration(color: primaryColor),
          height: MediaQuery.of(context).size.height * .17,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/Eventbrite_logo.png',
                width: 110,
                height: 110,
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Tue, Mar 7 - Thu, Mar 9 . 08:00 EET',
                    style: TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'The Design Show Egypt',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Opacity(
                    opacity: .7,
                    child: Text(
                      'Cairo International Convention Centre',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  FollowersAndIconsRow(),
                ],
              )
            ],
          ),
      ),
      ),
    );
  }
}
