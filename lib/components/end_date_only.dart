import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/creator/date_selection_provider.dart';

///This is a custom widget [EndSelectionWidget] to allow user to choose end date and end times
///It returns [Consumer] of type [DateSelectionModel] to update UI accoridng to user input and save the data
///It has consists of  [TextFormField] for the date and time
/// on Tap on the textfields we show [showTimePickerEnd] , [showDatePickerEnd] where they are accessed from the [DateSelectionModel] in order to allow them to set date and time
/// the input to the wigdet is the text that will be displayed as label to the date and time fields

class EndSelectionWidget extends StatefulWidget {
  const EndSelectionWidget({
    Key? key,
    required this.startDay,
    required this.time,
  }) : super(key: key);

  final String startDay;
  final String time;

  @override
  _EndSelectionWidgetState createState() => _EndSelectionWidgetState();
}

class _EndSelectionWidgetState extends State<EndSelectionWidget> {
  //final DateSelectionModel _model = DateSelectionModel();
  //to access time of day we use=> _timeOfDay.format(context).toString()


  @override
  Widget build(BuildContext context) {
    return Consumer<DateSelectionModel>(
      builder: (BuildContext context, model, Widget? child) => Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        //For a single event:
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              //width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                onTap: () {
                  model.showDatePickerStart(context);
                },
                //_showDatePickerStart,
                controller: model.dateControllerEnd,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.calendar_month_outlined),
                    labelText: widget.startDay,
                    // hintText: '05/02/2023',
                    labelStyle: const TextStyle(
                      fontSize: 18,
                    ),
                    border: const OutlineInputBorder(),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 32, horizontal: 10),
                    suffixIcon: const Text(
                      '*',
                      style: TextStyle(color: Colors.red, fontSize: 24),
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              //width: MediaQuery.of(context).size.width * 0.45,
              child: TextFormField(
                onTap: () {
                  model.showTimePickerStart(context);
                },
                controller: model.timeControllerEnd,
                decoration: InputDecoration(
                  labelText: widget.time,
                  // hintText: '7:00 PM',
                  labelStyle: const TextStyle(
                    fontSize: 18,
                  ),
                  border: const OutlineInputBorder(),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 10),
                  suffixIcon: const Text(
                    '*',
                    style: TextStyle(color: Colors.red, fontSize: 24),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
              ),
            ),
          ),
        ],

        //missing time zone + event language ====> idk if need api or wait for backend to do them? or if we will need them?
      ),
    );
  }
}
