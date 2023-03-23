import 'package:event_brite_app/reusable_widgets/event_item.dart';
import 'package:flutter/material.dart';
//import '../../reusable_widgets/event_item.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(
              top: 32,
              left: 7,
              right: 7,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Related to your orders',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 5, // will be changed later
                    itemBuilder: (context, index) {
                      return const EventItem(); // custom widget
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
