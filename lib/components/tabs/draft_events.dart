import 'package:flutter/material.dart';

import '../../functions/services/get_draft_events.dart';
import '../../models/basic_info_form.dart';
import '../../models/event_model.dart';
import '../draft_component.dart';

class DraftEventsTab extends StatelessWidget {
  const DraftEventsTab({super.key});

  final bool? noDrafts = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EventModel>>(
      future: AllDraftEventsServices().getAllDraftEvents(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching draft events'));
        }
        final eventDraftsList = snapshot.data ?? [];
        final noDrafts = eventDraftsList.isEmpty;
        print(noDrafts); //false
        return noDrafts!
            ? Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 3),
                  Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 2.0,
                        color: Colors.grey,
                      ),
                    ),
                    child: const Icon(
                      Icons.calendar_today,
                      size: 100.0,
                      color: Colors.grey,
                    ),
                  ),
                  const Spacer(flex: 1),
                  Container(
                      child: const Center(
                          child: Text('You don\'t have any draft events',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(236, 77, 77, 77))))),
                  const Spacer(flex: 3),
                ],
              )
            : Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ListView.builder(
                  itemCount: eventDraftsList.length,
                  itemBuilder: (context, index) {
                    final EventModel event = eventDraftsList[index];
                    print(eventDraftsList[index]);
                   // print(event.category);
                    return DraftComponent(event: event);
                  },
                ),
              );
      },
    );
  }
}
