import 'dart:convert';

import 'package:event_brite_app/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

void main() {
  testWidgets('publish function test', (WidgetTester tester) async {
    // Set up the initial state of the widget.
    await tester.pumpWidget(MyApp()); // Replace YourApp with the name of your Flutter app

    // Call the publish function
    await tester.runAsync(() async {
      publish(8855, 'Event Status', 'Audience Password', true, 'Publication Date');
    });

    // Wait for any asynchronous operations to complete
    await tester.pump();

    // Perform assertions
    expect(find.text('Publish successfully'), findsOneWidget);
    expect(find.text('failed'), findsNothing);
  });
}
void publish( int Event_ID, String Event_Status, String Audience_Password,bool Keep_Private,String Publication_Date ) async {
     
    //try{
      //email='joe@gmail.com';
      Event_ID=1936;
      String eva;
      eva=Event_ID.toString();
      int eventID = 7406; // integer variable
      print("pubdate:"+Publication_Date);
      print('eventstatus:'+Event_Status);
      print('pass:'+Audience_Password);
      print('keep:');
      print(Keep_Private);


//Future<void> publish(int id, bool abas, String isPrivate) async {
  final url = 'https://event-us.me:8000/eventmanagement/8855/publish/';
  //final headers = {'Content-Type': 'application/json'};
  String email="youssefsaadlotfy73@gmail.com";
  String password="Youssef@33";
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'CustomToken 65e1180796caf66355282edfae231cf52353ee8591a6efa8aa98d6ef76856a0c'


  };
  final body = 
  { 
    "Event_ID": "8855",
    "Event_Status": Event_Status,
    "Audience_Password":Audience_Password,
    "Keep_Private": Keep_Private,
    "Publication_Date": Publication_Date,
    //"error":"dfssdfsdfsuyu"
    };
    
  
  final response = await post(Uri.parse(url), headers: headers, body: jsonEncode(body));



      if(response.statusCode == 201){
        
        //var data = jsonDecode(response.body.toString());
        //print("token"+data['token']);
        print('Publish successfully');
       
      
      }else {
        print('failed');
      }
    // }catch(e){
    //   print('ypussef');
    //   print(e.toString());
    // }
  }