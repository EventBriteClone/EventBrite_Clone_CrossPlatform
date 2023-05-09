import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
//import 'package:my_flutter_app/auth.dart';

void main() {
  group('Authentication tests', () {
    test('Test login with correct credentials', () async {
      final auth = Auth();
      final result = await auth.AddAttendee("youssef", "saad", "youssefsaadlotfy@gmail.com", 1, "Free");
      expect(result, true); 
    });

    test('Test login with incorrect credentials', () async {
      final auth = Auth();
      final result = await auth.AddAttendee("FirstName", "LastName", "EmailAddress", 4, "sad");
      expect(result, false);
    });

    // test('Test sign up with new email', () async {
    //   final auth = Auth();
    //   final result = await auth.signUp('youssefsaadlotfyy12@gmail.com','youssef','saad', 'Youssef@33');
    //   expect(result, true);
    // });

    // test('Test sign up with existing email', () async {
    //   final auth = Auth();
    //   final result = await auth.signUp('youssefsaadlotfy73@gmail.com','youssef','saad', 'Youssef@33');
    //   expect(result, false);
    // });
  });
}

class Auth {
  //final String baseUrl = 'https://myapi.com/auth';
  //late String loggedInUser;
int findIdByTicketType( String ticketType) {
  Map<int, String> ticketMap={56143691: "Free"};
  for (MapEntry<int, String> entry in ticketMap.entries) {
    if (entry.value == ticketType) {
      return entry.key;
    }
  }
  return -1; // Return -1 if the ticket type is not found
} 
Future<bool> AddAttendee( String FirstName, String LastName, String EmailAddress,int numberOfTickets,String? TicketType) async {
    
    
    //try{
      //email='joe@gmail.com';
      int id = await  findIdByTicketType(TicketType!);
 print('email');    
 print(EmailAddress);
 print('first');
 print(FirstName+LastName);
 print('number');
 print(numberOfTickets);
 print('type');
 print(TicketType);
print ('id');
print(id);
//Future<void> publish(int id, bool abas, String isPrivate) async {
  final url = 'https://event-us.me:8000/eventmanagement/8244/add-attendee/';
  //final headers = {'Content-Type': 'application/json'};

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'CustomToken 65e1180796caf66355282edfae231cf52353ee8591a6efa8aa98d6ef76856a0c'


  };
  final body = 
 {
            
            "order_items":
            [
                {
                "ticket_class_id" : id,	
                "quantity": numberOfTickets
                }
            ], 
            //"promocode" : "sasfsf", // optional
            "first_name" : FirstName,
            "last_name" : LastName,
            "email" : EmailAddress
};
    
  
  final response = await post(Uri.parse(url), headers: headers, body: jsonEncode(body));



      if(response.statusCode == 201){
        
        //var data = jsonDecode(response.body.toString());
        //print("token"+data['token']);
        print('booked successfully');
        return true;
      
      }else {
        print('failed');
        return false;
      }
    // }catch(e){
    //   print('ypussef');
    //   print(e.toString());
    // }
  }
  
}
