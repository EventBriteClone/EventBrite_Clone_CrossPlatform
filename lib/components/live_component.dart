import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/basic_info_form.dart';
import '../models/event_model.dart';
import '../screens/creator/create_event/add_event_p_one.dart';

///This custom widget represents a [LiveComponent] which is a [StatelessWidget] that is used for representing each live component in the live events page
///It takes as input [event] object of type [EventModel] in order to display the live events data from the model

class LiveComponent extends StatelessWidget {
  final EventModel event;

  const LiveComponent({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? eventStDate = event.stDate;
    String? eventEndDate = event.endDate;
    String? eventStTime = event.stTime;
    String? eventEndTime = event.endTime;

    final eventStDateD = DateTime.parse(eventStDate!);
    final eventEndDateD = DateTime.parse(eventEndDate!);

    final List<String> stTimeSplit = eventStTime!.split(':');
    final List<String> endTimeSplit = eventEndTime!.split(':');
    final TimeOfDay startTime = TimeOfDay(
        hour: int.parse(stTimeSplit[0]), minute: int.parse(stTimeSplit[1]));
    final TimeOfDay endTime = TimeOfDay(
        hour: int.parse(endTimeSplit[0]), minute: int.parse(endTimeSplit[1]));

    final formattedStartTime = DateFormat.jm()
        .format(DateTime(1, 1, 1, startTime.hour, startTime.minute));
    final formattedEndTime =
        DateFormat.jm().format(DateTime(1, 1, 1, endTime.hour, endTime.minute));

    final formattedeventStDate = DateFormat('E, d MMM ').format(eventStDateD);
    final formattedeventEndDate = DateFormat('E, d MMM ').format(eventEndDateD);

    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (_) => AddEvents()));
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
                  event.title!,
                  style: TextStyle(
                      fontSize: 18, fontFamily: "Poppins", color: Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  //'$formattedDateStart , $formattedStartTime',

                  '$formattedeventStDate ,  $formattedStartTime',
                  style: TextStyle(
                      fontSize: 18, fontFamily: "Poppins", color: Colors.black),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
