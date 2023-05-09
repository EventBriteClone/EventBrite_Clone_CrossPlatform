import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
//import 'package:my_flutter_app/auth.dart';

void main() {
  group('Authentication tests', () {
    test('Test login with correct credentials', () async {
      final auth = Auth();
      final result = await auth.login('youssefsaadlotfy73@gmail.com', 'Youssef@33');
      expect(result, true); 
    });

    test('Test login with incorrect credentials', () async {
      final auth = Auth();
      final result = await auth.login('john.doe@example.com', 'wrong_password');
      expect(result, false);
    });

    test('Test sign up with new email', () async {
      final auth = Auth();
      final result = await auth.signUp('youssefsaadlotfyy12@gmail.com','youssef','saad', 'Youssef@33');
      expect(result, true);
    });

    test('Test sign up with existing email', () async {
      final auth = Auth();
      final result = await auth.signUp('youssefsaadlotfy73@gmail.com','youssef','saad', 'Youssef@33');
      expect(result, false);
    });
  });
}

class Auth {
  //final String baseUrl = 'https://myapi.com/auth';
  //late String loggedInUser;

  Future<bool> login(String email,String password) async {
    Response response = await post(
        Uri.parse('https://event-us.me:8000/user/login/'),
        body: {
          'email' : email,
          'password' : password
        }
      );

    if (response.statusCode == 200) {
      //var data = jsonDecode(response.body.toString());
      //final responseBody = jsonDecode(response.body);
      //loggedInUser = responseBody['email'];
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signUp(String email,String first,String last, String password) async {
    final url = 'https://event-us.me:8000/user/signup/';
    final response = await post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'email': email,
        'first_name':first,
        'last_name': last,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      //final responseBody = jsonDecode(response.body);
      return true;
    } else {
      return false;
    }
  }
}
