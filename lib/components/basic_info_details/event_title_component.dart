import 'package:flutter/material.dart';

import '../../models/basic_info_form.dart';

///This component is a [StatelessWidget] that just gets data from the form  [formData] and then display it in the UI
///It displays the [eventTitle],summary and descrption

class EventTitle extends StatelessWidget {
  const EventTitle({
    super.key,
    required this.eventTitle,
     this.summary,
     this.desc,
    required this.formData,
  });

  final String eventTitle;
  final String? summary;
  final String? desc;
  final BasicInfoFormData formData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/Tevents.png',
                width: MediaQuery.of(context).size.height * 0.1,
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Text(
                eventTitle,
                style: const TextStyle(
                    fontSize: 30,
                    fontFamily: "Poppins",
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 70.0),
            child: Text(
              '$eventTitle  Event',
              style: const TextStyle(fontSize: 20, fontFamily: "Poppins"),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 70.0, top: 30),
            child: Text(
              'Summary',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
           Padding(
            padding: EdgeInsets.only(left: 70.0),
            child: Text(
              summary ?? '',
              style: TextStyle(fontSize: 20, fontFamily: "Poppins"),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 70.0, top: 30),
            child: Text(
              'Description',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
           Padding(
            padding: EdgeInsets.only(left: 70.0),
            child: Text(
              desc ?? '',
              style: TextStyle(fontSize: 20, fontFamily: "Poppins"),
            ),
          ),
        ],
      ),
    );
  }
}
