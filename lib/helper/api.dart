import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<dynamic> get({required String url}) async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'There is a problem with status code ${response.statusCode}');
    }
  }

  Future<dynamic> post({
    required String url,
    @required dynamic body,
  }) async {
    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'There is a problem with the status code ${response.statusCode} with body ${jsonDecode(response.body )}');
    }
  }

  Future<dynamic> put({
    required String url,
    @required dynamic body,
  }) async {
    http.Response response = await http.put(
      Uri.parse(url),
      body: body,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'There is a problem with the status code ${response.statusCode} with body ${jsonDecode(response.body )}');
    }
  }
}


Future<Map<String, dynamic>> getAllEvents(http.Client client) async {

  http.Response response = await client.get(Uri.parse('http://127.0.0.1:8003/events/ALL/'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception(
        'There is a problem with status code ${response.statusCode}');
  }
}
