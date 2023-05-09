import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

Future<Map<int, String>> fetchTicketTypes(http.Client client) async {
  final url = 'https://event-us.me:8000/events/ALLTickets/8244/';
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'CustomToken 65e1180796caf66355282edfae231cf52353ee8591a6efa8aa98d6ef76856a0c',
  };

  final response = await client.get(Uri.parse(url), headers: headers);

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body) as List<dynamic>;

    Map<int, String> ticketMap = {};

    for (var item in jsonData) {
      int id = item['ID'];
      String ticketType = item['TICKET_TYPE'];

      ticketMap[id] = ticketType;
    }

    return ticketMap;
  } else {
    throw Exception('Failed to fetch ticket types');
  }
}

void main() {
  final mockClient = MockClient();

  test('fetchTicketTypes should return the expected ticket map', () async {
    final responseJson = [
    {
        "ID": 81333106,
        "event_id": 8244,
        "User_id": 8,
        "NAME": null,
        "PRICE": 0.0,
        "capacity": 5,
        "quantity_sold": 5,
        "TICKET_TYPE": "Free",
        "Sales_start": "2023-05-08",
        "Sales_end": "2023-05-08",
        "Start_time": "12:12:00",
        "End_time": "12:12:00",
        "Absorb_fees": "True"
    },
    {
        "ID": 72985160,
        "event_id": 8244,
        "User_id": 8,
        "NAME": null,
        "PRICE": 50.0,
        "capacity": 5,
        "quantity_sold": 5,
        "TICKET_TYPE": "Free",
        "Sales_start": "2023-05-08",
        "Sales_end": "2023-05-08",
        "Start_time": "12:12:00",
        "End_time": "12:12:00",
        "Absorb_fees": "True"
    },
    {
        "ID": 56143691,
        "event_id": 8244,
        "User_id": 8,
        "NAME": null,
        "PRICE": 50.0,
        "capacity": 5,
        "quantity_sold": 0,
        "TICKET_TYPE": "Free",
        "Sales_start": "2023-05-08",
        "Sales_end": "2023-05-08",
        "Start_time": "12:12:00",
        "End_time": "12:12:00",
        "Absorb_fees": "True"
    }
    ];

    final expectedTicketMap = {
      81333106: "Free",
      72985160: "Paid",
      56143691: "Free"

    };

    final response = http.Response(jsonEncode(responseJson), 200);

    when(mockClient.get(
      Uri.parse('https://event-us.me:8000/events/ALLTickets/8244/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'CustomToken 65e1180796caf66355282edfae231cf52353ee8591a6efa8aa98d6ef76856a0c',
      },
    )).thenAnswer((_) async => response);

    final result = await fetchTicketTypes(mockClient);

    expect(result, equals(expectedTicketMap));
    verify(mockClient.get(
      Uri.parse('https://event-us.me:8000/events/ALLTickets/8244/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'CustomToken 65e1180796caf66355282edfae231cf52353ee8591a6efa8aa98d6ef76856a0c',
      },));});}
