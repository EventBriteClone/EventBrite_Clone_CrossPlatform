// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:event_brite_app/screens/creator/basic_info/add_attendee_page_2.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../providers/creator/basic_info_provider.dart';
import '../../../providers/token_provider.dart';
import '../../../reusable_widgets/creator_custom_button.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int textFieldCount = 0;
  bool _isLoading = false;
  String _errorMessage = '';
    int? event_ID;
  String? token; 
// Future<Map<int, String>> removeRedundancy(Map map) async{

//   Map<int, String> result = {};

//   map.forEach((key, value) {
//     if (!result.containsValue(value)) {
//       result[key] = value;
//     }
//   });

//   return result;
// }
  Future<Map<int, String>> removeRedundancy(Map map) async {
    Map reversedMap = {};

    map.forEach((key, value) {
      reversedMap[value] = key;
    });

    Map<int, String> result = {};

    reversedMap.forEach((key, value) {
      if (!result.containsValue(key)) {
        result[value] = key;
      }
    });

    return result;
  }

  Future<Map<int, String>> fetchTicketTypes() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    final url =
        'https://event-us.me:8000/events/ALLTickets/$event_ID/'; // Replace with your API URL
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'CustomToken $token'
    };

    final response = await get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List<dynamic>;

      Map<int, String> ticketMap = {};

      for (var item in jsonData) {
        int id = item['ID'];
        String ticketType = item['TICKET_TYPE'];

        ticketMap[id] = ticketType;
      }
      setState(() {
        _isLoading = false;
        _errorMessage = '';
      });
      return ticketMap;
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = '';
      });
      throw Exception('Failed to fetch ticket types');
    }
  }

// Future<List<String>> fetchTicketTypes() async {
//   final url = 'https://event-us.me:8000/events/ALLTickets/8244/'; // Replace with your API URL
//   final headers = {
//     'Content-Type': 'application/json',
//     'Authorization': 'CustomToken 65e1180796caf66355282edfae231cf52353ee8591a6efa8aa98d6ef76856a0c'

//   };
//   final response = await get(Uri.parse(url),headers: headers);

//   if (response.statusCode == 200) {
//     final jsonData = jsonDecode(response.body) as List<dynamic>;
//     final ticketTypes = jsonData.map((data) => data['TICKET_TYPE'] as String).toList();
//     return ticketTypes;
//   } else {
//     throw Exception('Failed to fetch ticket types');
//   }
// }
  void setTextFieldCount(int count) {
    setState(() {
      textFieldCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
        final eventModel =
        Provider.of<BasicInfoFormDataProvider>(context, listen: false);
    print(eventModel.eventId);
    event_ID=eventModel.eventId;
    token = Provider.of<TokenModel>(context).token;
    return Scaffold(
      key: const Key('scaffold of the add attendee page'),
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   shadowColor: Colors.grey,
      //   iconTheme: IconThemeData(color: Colors.black, size: 27),
      //   title: Text('Manage attendee ',
      //       style: TextStyle(
      //         fontSize: 27, fontFamily: 'Neue_Plak',
      //         color: Colors.black, //fontWeight: FontWeight.w900,
      //       )),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.,
          children: [
            SizedBox(
              height: 100,
            ),

            Text(
              'Add Attendee using their EmailAddress',
              style: TextStyle(
                //decorationThickness: 500,
                fontSize: 25,
                fontFamily: 'Neue_Plak',
                color: Colors.black,
              ),
            ),
            //Text()
            //Text('Enter the number of text fields:'),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CreatorCustomButton(
                          key: const ValueKey(
                              "button in manage attendee page 1"),
                          onTap: _isLoading
                              ? () async {
                                  //getTicketTypes() async {
                                  //try {
                                  null;
                                }
                              : () async {
                                  final ticketTypes = await fetchTicketTypes();

                                  // Do something with the ticket types
                                  print(ticketTypes);
                                  final tickettype =
                                      await removeRedundancy(ticketTypes);
                                  print(tickettype);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CounterList(
                                        TicketMap:
                                            tickettype, // Pass the dropdown values here
                                      ),
                                    ),
                                  );
                                },
                          child: _isLoading
                              ? SizedBox(
                                  width: 10,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.grey,
                                    ),
                                  ))
                              : Center(
                                  child: Text(
                                  'Next',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ))),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
