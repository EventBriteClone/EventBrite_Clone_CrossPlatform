import 'package:flutter/material.dart';

import '../../functions/services/get_draft_events.dart';
import '../../functions/services/get_live_events.dart';
import '../../functions/services/get_past_events.dart';
import '../../models/basic_info_form.dart';
import '../../models/event_model.dart';
import '../../reusable_widgets/NoComponentWidget.dart';
import '../draft_component.dart';
import '../live_component.dart';
import '../past_component.dart';

class PastEventsTab extends StatelessWidget {
  const PastEventsTab({super.key});

  final bool? noPasts = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EventModel>>(
      future: AllPastEventsServices().getAllPastEvents(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching draft events'));
        }
        final eventPastList = snapshot.data ?? [];
        final noPasts = eventPastList.isEmpty;
        //print(noDrafts); //false
        return noPasts!
            ? const NoComponentWidget(
                displayText: 'You don\'t have any live events',
                icon: Icons.calendar_today)
            : Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ListView.builder(
                  itemCount: eventPastList.length,
                  itemBuilder: (context, index) {
                    final EventModel event = eventPastList[index];
                    print(eventPastList[index]);
                    // print(event.category);
                    return PastComponent(event: event);
                  },
                ),
              );
      },
    );
  }
}
