import 'package:flutter/material.dart';

///This is a component widget where it consists of the UI of  [EventDateDetails] to show the data user has filled from teh form related to the date
///We have a constructor that takes as agruments=> [formattedDateStart], [formattedStartTime],[formattedDateEnd], [formattedEndTime]
/// where they are formatted to the required format: 'Thu, Apr 20, 2023, 7:00 AM'
/// They are inside a [Column] widget
class EventDateDetails extends StatelessWidget {
  const EventDateDetails({
    super.key,
    required this.formattedDateStart,
    required this.formattedStartTime,
    required this.formattedDateEnd,
    required this.formattedEndTime,
  });

  final String formattedDateStart;
  final String formattedStartTime;
  final String formattedDateEnd;
  final String formattedEndTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: 45.0 * MediaQuery.of(context).textScaleFactor,
                  color: const Color.fromARGB(255, 198, 198, 198),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text('Event Starts',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 70.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      formattedDateStart,
                      style:
                          const TextStyle(fontSize: 20, fontFamily: "Poppins"),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Text(
                      formattedStartTime,
                      style:
                          const TextStyle(fontSize: 20, fontFamily: "Poppins"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Event Ends',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Text(
                      formattedDateEnd,
                      style:
                          const TextStyle(fontSize: 20, fontFamily: "Poppins"),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Text(
                      formattedEndTime,
                      style:
                          const TextStyle(fontSize: 20, fontFamily: "Poppins"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
