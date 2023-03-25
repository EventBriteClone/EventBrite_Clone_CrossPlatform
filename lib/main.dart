import 'package:flutter/material.dart';
import 'package:organizer/screens/add_event.dart';
import 'package:organizer/screens/events.dart';

void main() {
  runApp(const EventBriteapp());
}

class EventBriteapp extends StatelessWidget {
  const EventBriteapp({super.key});

  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: EventPage(),
      //home: AddEvents(),
      //debugShowCheckedModeBanner: false,
    );
  }
}
