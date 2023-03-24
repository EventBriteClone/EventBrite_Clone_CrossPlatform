import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


//my api: AIzaSyAn62FAeiVkL0JT_jI0LmZjibiUGrCb3dw
//kareem's api: 

class Api {
  //here we will have all the response functions we need=> get, post, delete....
  //this will be called on (get_service)

  //our get method:
  // Future<http.Response> get({required String url}) async {
  //   //getting the response from the url (which will be inside the paramters of the functions)
  //   http.Response response = await http.get(Uri.parse(url));

  //   //checking on the response:
  //   if (response.statusCode == 200) {
  //     return response;
  //   } else {
  //     throw Exception(
  //         'there is a problem with status code ${response.statusCode}');
  //   }
  // }

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
}
