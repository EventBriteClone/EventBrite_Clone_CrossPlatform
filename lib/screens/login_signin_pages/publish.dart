import 'dart:convert';

import 'package:event_brite_app/constants.dart';
import 'package:event_brite_app/screens/creator/basic_info/publish.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../../reusable_widgets/creator_custom_button.dart';
import '../../reusable_widgets/neu.dart';

class DependentDropdownMenu extends StatefulWidget {
  @override
  _DependentDropdownMenuState createState() => _DependentDropdownMenuState();
}

class _DependentDropdownMenuState extends State<DependentDropdownMenu> {
  String _dropdownValue = 'Public';
  bool _showCheckbox = false;
  bool _switchValue = false;
  bool _checkboxValue = false;
  bool _switchValue2 = false;
  DateTime? _selectedDateTime;
  bool _isLoading = false;
  String _errorMessage = '';
  String? formattedTime;
  TextEditingController passwordController = TextEditingController();
/////
  void publish(int Event_ID, String Event_Status, String Audience_Password,
      bool Keep_Private, String Publication_Date) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    //try{
    //email='joe@gmail.com';
    Event_ID = 1936;
    String eva;
    eva = Event_ID.toString();
    int eventID = 7406; // integer variable
    print("pubdate:" + Publication_Date);
    print('eventstatus:' + Event_Status);
    print('pass:' + Audience_Password);
    print('keep:');
    print(Keep_Private);

//Future<void> publish(int id, bool abas, String isPrivate) async {
    final url = 'https://event-us.me:8000/eventmanagement/8244/publish/';
    //final headers = {'Content-Type': 'application/json'};
    String email = "youssefsaadlotfy73@gmail.com";
    String password = "Youssef@33";
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'CustomToken 65e1180796caf66355282edfae231cf52353ee8591a6efa8aa98d6ef76856a0c'
    };
    final body = {
      "Event_ID": "8244",
      "Event_Status": Event_Status,
      "Audience_Password": Audience_Password,
      "Keep_Private": Keep_Private,
      "Publication_Date": Publication_Date,
      //"error":"dfssdfsdfsuyu"
    };

    final response =
        await post(Uri.parse(url), headers: headers, body: jsonEncode(body));

    if (response.statusCode == 201) {
      //var data = jsonDecode(response.body.toString());
      //print("token"+data['token']);
      print('Publish successfully');
    } else {
      print('failed');
    }
    // }catch(e){
    //   print('ypussef');
    //   print(e.toString());
    // }
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        iconTheme: IconThemeData(color: Colors.black, size: 27),
        title: Text('Settings',
            style: TextStyle(
              fontSize: 27, fontFamily: 'Neue Plak',
              color:
                  Color.fromRGBO(60, 0, 100, 1), //fontWeight: FontWeight.w900,
            )),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                child: DropdownButton<String>(
                  value: _dropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      _dropdownValue = newValue!;
                      if (_dropdownValue == 'Private') {
                        _showCheckbox = true;
                      } else {
                        _showCheckbox = false;
                      }
                    });
                  },
                  items: <String>['Public', 'Private'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 5),
              _dropdownValue == 'Public'
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                              'This event will be listed on eventus and in search engines'),
                        ),
                        Divider(),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CreatorCustomButton(
                              onTap: () {
                                publish(
                                    1,
                                    "Public",
                                    passwordController.text.toString(),
                                    _switchValue,
                                    _selectedDateTime.toString());
                              },
                              child: Center(
                                  child: Text(
                                'Publish',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w900),
                              )),
                            ),
                          ),
                        )
                      ],
                    )
                  : Column(
                      children: [
                        Text(
                            'This event will not be listed on Eventus or in search engines'),
                        Divider(),
                        Divider(),
                        SwitchListTile(
                          title: Text('Guests must enter password to register'),
                          value: _switchValue,
                          activeColor: Color.fromRGBO(60, 0, 100, 1),
                          onChanged: (newValue) {
                            setState(() {
                              _switchValue = newValue;
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        _switchValue
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Password',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        Divider(),
                        SwitchListTile(
                          title: Text(
                              'Make the Event public after a certain date'),
                          activeColor: Color.fromRGBO(60, 0, 100, 1),
                          value: _switchValue2,
                          onChanged: (bool newValue) {
                            setState(() {
                              _switchValue2 = newValue;
                            });
                          },
                        ),
                        if (_switchValue2)
                          ElevatedButton(
                            key: const ValueKey("elevted button in publish"),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromRGBO(60, 0, 100, 1)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            onPressed: () {
                              _selectDateTime(context);
                            },
                            child: Text(_selectedDateTime != null
                                ? 'Selected Date Time: $_selectedDateTime'
                                : 'Select Date Time'),
                          ),
                        Divider(),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CreatorCustomButton(
                            onTap: () {
                              publish(
                                  2222,
                                  "Private",
                                  passwordController.text.toString(),
                                  !_switchValue2,
                                  formattedTime!);
                            },
                            child: Center(
                                child: Text(
                              'Publish',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w900),
                            )),
                          ),
                        )
                      ],
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      final TimeOfDay? timePicked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (timePicked != null) {
        setState(() {
          _selectedDateTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            timePicked.hour,
            timePicked.minute,
          );
          formattedTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
              .format(_selectedDateTime!);
        });
      }
    }
  }
}
