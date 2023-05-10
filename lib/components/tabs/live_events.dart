import 'package:flutter/material.dart';

import '../../functions/services/get_draft_events.dart';
import '../../functions/services/get_live_events.dart';
import '../../models/basic_info_form.dart';
import '../../models/event_model.dart';
import '../../reusable_widgets/NoComponentWidget.dart';
import '../draft_component.dart';
import '../live_component.dart';

/// A tab that displays a list of live events. It fetches the data asynchronously using [AllLiveEventsServices]
/// and shows a loading indicator while waiting for the data. If there are no lives available, it displays a [NoComponentWidget]
///  Otherwise, it shows a [ListView] with a [LiveComponent] for each live event

class LiveEventsTab extends StatelessWidget {
  const LiveEventsTab({super.key});

  final bool? noLives = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EventModel>>(
      future: AllLiveEventsServices().getAllLiveEvents(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching draft events'));
        }
        final eventLiveList = snapshot.data ?? [];
        final noLives = eventLiveList.isEmpty;
        //print(noDrafts); //false
        return noLives!
            ? const NoComponentWidget(
                displayText: 'You don\'t have any live events',
                icon: Icons.calendar_today)
            : Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ListView.builder(
                  itemCount: eventLiveList.length,
                  itemBuilder: (context, index) {
                    final EventModel event = eventLiveList[index];
                    print(eventLiveList[index]);
                    // print(event.category);
                    return LiveComponent(event: event);
                  },
                ),
              );
      },
    );
  }
}

/*
import 'package:flutter/material.dart';

class LiveEventsTab extends StatelessWidget {
  const LiveEventsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(flex:3),
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
          child: Icon(
            Icons.calendar_today,
            size: 100.0,
            color: Colors.grey,
          ),
        ),
        const Spacer(flex:1),
        Container(
            child: Center(
                child: Text('You don\'t have any live events',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(236, 77, 77, 77))))),
        const Spacer(flex:3),
      ],
    );
  }
}
*/