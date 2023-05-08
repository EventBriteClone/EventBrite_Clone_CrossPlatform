import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  MockClient mockClient = MockClient();

  setUp(() {
    mockClient = MockClient();
  });

  test('Test login request', () async {
    final email = 'joe@gmail.com';
    final password = 'password123';

    final expectedResponse = {
      'email': email,
      'token': 'mocked_token',
    };

    // Mock the response
    when(mockClient.post(
      Uri.parse('https://event-us.me:8000/user/login/'),
      body: {'email': email, 'password': password},
    )).thenAnswer((_) async => http.Response(jsonEncode(expectedResponse), 200));

    // Call your login function
    final result = await login(email, password, client: mockClient);

    // Verify the request was made
    verify(mockClient.post(
      Uri.parse('https://event-us.me:8000/user/login/'),
      body: {'email': email, 'password': password},
    ));

    // Verify the result
    expect(result, 'mocked_token');
  });
}

Future<String?> login(String email, String password,
    {required http.Client client}) async {
  final httpClient = client;  http.Client();

  try {
    final response = await httpClient.post(
      Uri.parse('https://event-us.me:8000/user/login/'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String token = data['token'].toString();
      print("token:" + data['token']);
      print('Login successfully');
      print('asdasd' + token);
      return token;
    } else {
      print('failed');
    }
  } catch (e) {
    print('ypussef');
    print(e.toString());
  } finally {
    httpClient.close();
  }

  return null;
}
