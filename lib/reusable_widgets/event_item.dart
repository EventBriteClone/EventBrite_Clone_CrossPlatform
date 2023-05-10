// ignore_for_file: use_key_in_widget_constructors

import 'package:event_brite_app/screens/event_details_screen/event_details_screen.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'followers_and_icons_row.dart';

class EventItem extends StatelessWidget {
  EventItem({
    key,
    this.stDate,
    this.endDate,
    this.stTime,
    this.title,
    this.venue,
    this.ID,
    this.imageURL,
  });
  final String? stDate;
  final String? endDate;
  final String? stTime;
  final String? title;
  final String? venue;
  final int? ID;
  final String? imageURL;
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: primaryColor),
      height: MediaQuery.of(context).size.height * .17,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network(
            'https://event-us.me:8000$imageURL',
            /*Image.asset(
            'assets/images/Eventbrite_logo.png',*/
            width: MediaQuery.of(context).size.width * 0.22,
            height: MediaQuery.of(context).size.width * 0.22,
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$stDate - $endDate . $stTime',
                style: const TextStyle(
                  color: secondaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.0001,
              ),
              Text(
                title!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
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
                  venue!,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              FollowersAndIconsRow(
                isLiked: isLiked,
              ),
            ],
          )
        ],
      ),
    );
  }
}
