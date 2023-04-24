import 'package:flutter/material.dart';

///This is a component widget where it consists of the UI of  [EventTypeCategory] to show the data user has filled from teh form related to the type and categpru
///We have a constructor that takes as agruments=> [type], [category]

/// They are inside a [Column] widget
///
class EventTypeCategory extends StatelessWidget {
  const EventTypeCategory({
    super.key,
    required this.type,
    required this.category,
  });

  final String type;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.discount_outlined,
            size: 45.0 * MediaQuery.of(context).textScaleFactor,
            color: Color.fromARGB(255, 198, 198, 198),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Event type',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                type,
                style: const TextStyle(fontSize: 20, fontFamily: "Poppins"),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Event Category',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                category,
                style: const TextStyle(fontSize: 20, fontFamily: "Poppins"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
