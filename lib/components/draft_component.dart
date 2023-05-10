import 'package:event_brite_app/screens/creator/basic_info/basic_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/basic_info_form.dart';
import '../screens/creator/create_event/add_event_p_one.dart';

///This is a [DraftComponent] widget that displays created events that are not yet published
///It shows the event data using [BasicInfoFormData] object called [event] which represents the event model.
///[event] is input parameter to the widget
///we also have a [editDeleteView]. The [editDeleteView] function displays a modal bottom sheet that allows the user to edit or delete the event object, or to view its basic info

class DraftComponent extends StatelessWidget {
  final BasicInfoFormData event;

  const DraftComponent({Key? key, required this.event}) : super(key: key);

  @override
  Key? get key => super.key;

  @override
  Widget build(BuildContext context) {
    DateTime? eventStDate = event.eventStart;
    DateTime? eventEndDate = event.eventEnd;
    TimeOfDay? eventStTime = event.startTime;
    TimeOfDay? eventEndTime = event.endTime;

    final formattedStartTime = DateFormat.jm()
        .format(DateTime(1, 1, 1, eventStTime!.hour, eventStTime.minute));
    final formattedEndTime = DateFormat.jm()
        .format(DateTime(1, 1, 1, eventEndTime!.hour, eventEndTime.minute));

    final formattedeventStDate = DateFormat('E, d MMM ').format(eventStDate!);
    final formattedeventEndDate = DateFormat('E, d MMM ').format(eventEndDate!);

    return InkWell(
      key: key,
      onTap: () {
        editDeleteView(context);
      },
      child: Expanded(
        child: Container(
          decoration: BoxDecoration(
              border:
                  Border.all(color: const Color.fromARGB(122, 158, 158, 158))),
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.width,
          child: Row(mainAxisSize: MainAxisSize.max, children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          style: BorderStyle.solid, color: Colors.grey)),
                  child: const Icon(
                    Icons.mode_edit_outline,
                    color: Colors.grey,
                    size: 50,
                  )),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.eventTitle!,
                  style: const TextStyle(
                      fontSize: 18, fontFamily: "Poppins", color: Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  //'$formattedDateStart , $formattedStartTime',

                  '$formattedeventStDate ,  $formattedStartTime',
                  style: const TextStyle(
                      fontSize: 18, fontFamily: "Poppins", color: Colors.black),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Future<dynamic> editDeleteView(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.25,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddEvents(
                        previousBasicInfoData: event,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.remove_circle_outline),
                title: const Text('Delete'),
                onTap: () {
                  // Delete the event here
                  //Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.remove_red_eye),
                title: const Text('View'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BasicInfo(
                        previousBasicInfoData: event,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
