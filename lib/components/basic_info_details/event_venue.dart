import 'package:flutter/material.dart';

///This is a component widget where it consists of the UI of  [EventVenue] to show the data user has filled from teh form related to the location
///We have a constructor that takes as agruments=> [location]

/// They are inside a [Column] widget
///
///
class EventVenue extends StatelessWidget {
  const EventVenue({
    super.key,
    required this.location,
  });

  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 45.0 * MediaQuery.of(context).textScaleFactor,
            color: const Color.fromARGB(255, 198, 198, 198),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Venue Address',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                location,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 20, fontFamily: "Poppins"),
                softWrap: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
