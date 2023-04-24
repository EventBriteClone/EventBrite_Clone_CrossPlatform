import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/basic_info_form.dart';
import '../screens/creator/create_event/add_event_p_one.dart';

class DraftComponent extends StatelessWidget {
  final BasicInfoFormData event;

  const DraftComponent({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDateStart = '';
    String formattedDateEnd = '';
    String formattedStartTime = '';
    String formattedEndTime = '';

    final eventStart = event.eventStart!;
    final eventEnd = event.eventEnd!;
    final startTime = event.startTime!;
    final endTime = event.endTime!;
    formattedDateStart = eventStart.toString().substring(0, 10);
    formattedDateStart = DateFormat('E, d MMM ').format(eventStart);
    formattedDateEnd = eventEnd.toString().substring(0, 10);
    formattedDateEnd = DateFormat('E, d MMM ').format(eventEnd);

    formattedStartTime = DateFormat.jm()
        .format(DateTime(1, 1, 1, startTime.hour, startTime.minute));
    formattedEndTime =
        DateFormat.jm().format(DateTime(1, 1, 1, endTime.hour, endTime.minute));

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => AddEvents()));
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
                  style: TextStyle(
                      fontSize: 18, fontFamily: "Poppins", color: Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '$formattedDateStart , $formattedStartTime',
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
