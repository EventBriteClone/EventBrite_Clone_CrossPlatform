import 'package:flutter/material.dart';
import 'package:organizer/screens/creator/create_event/add_event_p_one.dart';

import '../components/draft_component.dart';
import '../models/basic_info_form.dart';
import '../services/get_draft_events.dart';

class DraftEventsTab extends StatelessWidget {
  const DraftEventsTab({super.key});

  final bool? noDrafts = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BasicInfoFormData>>(
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
            // : Padding(
            //     padding: const EdgeInsets.only(top: 20.0),
            //     child: ListView(
            //       children: [DraftComponent()],
            //     ),
            //   );

            : Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ListView.builder(
                  itemCount: eventDraftsList.length,
                  itemBuilder: (context, index) {
                    final event = eventDraftsList[index];
                    return DraftComponent(event: event);
                  },
                ),
              );
      },
    );
  }
}


/*

//my code:
class DraftEventsTab extends StatelessWidget {
  const DraftEventsTab({super.key});

  final bool? noDrafts = false;

  @override
  Widget build(BuildContext context) {
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
            child: ListView(
              children: [DraftComponent()],
            ),
          );
  }
}


*/



/*


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
                    final event = eventDraftsList[index];
                    return DraftComponent(event: event);
                  },
                ),
              );
      },
    );
  }
}

*/