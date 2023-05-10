import 'package:flutter/material.dart';

import '../../functions/services/get_draft_events.dart';
import '../../models/basic_info_form.dart';
import '../../models/event_model.dart';
import '../../reusable_widgets/NoComponentWidget.dart';
import '../draft_component.dart';

/// A tab that displays a list of draft events. It fetches the data asynchronously using [AllDraftEventsServices]
/// and shows a loading indicator while waiting for the data. If there are no drafts available, it displays a [NoComponentWidget]
///  Otherwise, it shows a [ListView] with a [DraftComponent] for each draft event

class DraftEventsTab extends StatelessWidget {
  const DraftEventsTab({super.key});

  final bool? noDrafts = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BasicInfoFormData>>(
      future: AllDraftEventsServices().getAllDraftEvents(context),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching draft events'));
        }
        final eventDraftsList = snapshot.data ?? [];
        final noDrafts = eventDraftsList.isEmpty;
        //print(noDrafts); //false
        return noDrafts!
            ? const NoComponentWidget(
                displayText: 'You don\'t have any draft events',
                icon: Icons.calendar_today)
            : Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ListView.builder(
                  itemCount: eventDraftsList.length,
                  itemBuilder: (context, index) {
                    //final EventModel event = eventDraftsList[index];
                    final BasicInfoFormData event = eventDraftsList[index];
                    print(eventDraftsList[index]);
                    // print(event.category);
                    return DraftComponent(
                        key: const ValueKey("draftcomponent"), event: event);
                  },
                ),
              );
      },
    );
  }
}
