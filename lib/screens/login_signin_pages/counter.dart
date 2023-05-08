import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CounterList extends StatefulWidget {
  @override
  _CounterListState createState() => _CounterListState();
}

class _CounterListState extends State<CounterList> {
  List<int> counters = [0];
  String? selectedOption;

  void incrementCounter(int index) {
    setState(() {
      counters[index] += 1;
    });
  }

  void decrementCounter(int index) {
    setState(() {
      if (counters[index] > 0) {
        counters[index] -= 1;
      }
    });
  }

  void AddAttendee(
      int Event_ID, String Event_Status, String Audience_Password, bool Keep_Private, String Publication_Date) async {
    // Implement your add attendee logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter List'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'FirstName',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'LastName',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email Address',
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: counters.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Number of tickets for attendee ${index + 1}: ${counters[index]}'),
                  trailing: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () => decrementCounter(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () => incrementCounter(index),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            DropdownButton<String>(
              value: selectedOption,
              hint: Text('Select an option'),
              onChanged: (newValue) {
                setState(() {
                  selectedOption = newValue;
                });
              },
              items: <String>[
                'Option 1',
                'Option 2',
                'Option 3',
                'Option 4',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom), // Adjusts the bottom spacing to make room for the keyboard
          ],
        ),
      ),
    );
  }
}


