import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

//my api: AIzaSyAn62FAeiVkL0JT_jI0LmZjibiUGrCb3dw
//kareem's api:

///This is the [Api] class that contains all kind of requests we might need
///It has a [get] , [post] requests
///It also has  a [fetchUrl] request

class Api {
  static Future<String?> fetchUrl(Uri uri,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<dynamic> get({required String url, required String token}) async {
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: token,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'There is a problem with status code ${response.statusCode}');
    }
  }

  Future<dynamic> getM({required String url, @required String? token}) async {
    Map<String, String> headers = {};

    if (token != null) {
      headers.addAll({'Authorization': ' $token'});
    }
    http.Response response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode}');
    }
  }

  Future<Map> post(
      {required String url,
      required Map<String, dynamic> body,
      File? file,
      required String? token}) async {
    Map<String, String> headers = {};

    if (token != null) {
      headers.addAll(
          {'Authorization': '$token', 'Content-Type': 'application/json'});
    }

    var response = await http.post(Uri.parse(url),
        body: jsonEncode(body), headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> data = jsonDecode(response.body);

      return data;
    } else {
      // return {"tickets": []};
      throw Exception(

          'there is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }

  Future<dynamic> postWithFile({
    required String url,
    required Map<String, dynamic> body,
    String? token,
    File? file,
  }) async {
    // Create a map to store any headers that need to be sent with the request
    final headers = <String, String>{};

    // If a token is provided, add it to the headers
    if (token != null) {
      headers['Authorization'] = token;
    }

    final fields = body.map((key, value) => MapEntry(key, value.toString()));
    // Create a new multipart request with the provided URL and headers
    final request = http.MultipartRequest('POST', Uri.parse(url))
      ..headers.addAll(headers)
      ..fields.addAll(fields); // Add any fields from the body to the request

    // If a file is provided, create a new multipart file and add it to the request
    if (file != null) {
      final stream = http.ByteStream(Stream.castFrom(
          file.openRead())); // Create a ByteStream from the file's read stream
      final length = await file.length(); // Get the length of the file

      final multipartFile = http.MultipartFile(
        'image', // Field name for the file in the multipart request
        stream, // ByteStream of the file's data
        length, // Length of the file
        filename: file.path
            .split('/')
            .last, // Name of the file as it should appear in the request
      );

      request.files.add(multipartFile); // Add the multipart file to the request
    }

    // Send the request and get the response
    final response = await request.send();

    // Convert the response stream to a string
    final responseData = await response.stream.transform(utf8.decoder).join();

    // If the response status code is 200, decode the response data as JSON and return it
    if (response.statusCode == 201) {
      return jsonDecode(responseData);
    } else {
      // If the response status code is not 200, throw an exception with details about the response
      throw Exception(
          'There was a problem with status code ${response.statusCode} with body $responseData');
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
          'There is a problem with the status code ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }
}

Future<Map<String, dynamic>> getAllEvents(http.Client client) async {
  http.Response response =
      await client.get(Uri.parse('http://127.0.0.1:8003/events/ALL/'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception(
        'There is a problem with status code ${response.statusCode}');
  }
}
