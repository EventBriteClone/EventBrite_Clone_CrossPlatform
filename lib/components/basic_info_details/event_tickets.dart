import 'package:flutter/material.dart';

///This is a component widget where it consists of the UI of  [EventTickets] to show the data user has filled from teh form related to the tickets
/// They are inside a [Column] widget

class EventTickets extends StatelessWidget {
  const EventTickets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.confirmation_num_outlined,
            size: 45.0 * MediaQuery.of(context).textScaleFactor,
            color: Color.fromARGB(255, 198, 198, 198),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Tickets',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'None',
                style: TextStyle(fontSize: 20, fontFamily: "Poppins"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
