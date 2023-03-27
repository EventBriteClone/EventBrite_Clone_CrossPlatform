import 'dart:io';
import 'package:event_brite_app/helper/api.dart';
import 'package:event_brite_app/models/event_model.dart';
import 'package:mockito/mockito.dart';

import 'events_list_test.mocks.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

@GenerateMocks([http.Client])
void main() {
  group('events', () {
    test('getEvents', () async {
      final client = MockClient();

      when(client.get(Uri.parse('http://127.0.0.1:8003/events/ALL/')))
          .thenAnswer(
        (_) async => http.Response(
            '{"id": "1", "User_id": "2", "Title": "mock", "organizer" : "Kareem", "Description" : "dbg", "type" : "party", "Category" : "community", "sub_Category": "subCategory","venue_name": "venueName","CATEGORY_ID": "categoryId", "SUB_CATEGORY_ID": "5","ST_DATE": "stDate","END_DATE": "endDate","ST_TIME": "stTime","END_TIME": "endTime","online": "online","CAPACITY": "capacity","PASSWORD": "password","locationـid": "locationId","STATUS": "status"}',
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            }),
      );
      expect(await getAllEvents(client), isA<Map<String,dynamic>>());
    });
    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('http://127.0.0.1:8003/events/ALL/')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(getAllEvents(client), throwsException);
    });
  });
}
