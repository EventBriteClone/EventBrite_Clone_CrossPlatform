import 'package:flutter/material.dart';

import '../screens/creator/events_page/events.dart';

///[backButtonToEvents] is  function that returns [Padding] that consists of an [IconButton] that is [arrow_back] which navigates to [EventPage]

Padding backButtonToEvents(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 30, left: 20),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 4, 0, 213),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EventPage()),
            );
          },
        ),
        const Text(
          'Events',
          style: TextStyle(
            fontSize: 20.0,
            color: Color.fromARGB(255, 4, 0, 213),
          ),
        ),
      ],
    ),
  );
}
