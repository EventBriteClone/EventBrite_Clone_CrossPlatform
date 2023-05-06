import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GmailPage extends StatelessWidget {
  const GmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(backgroundColor: Colors.white,
      shadowColor: Colors.grey,
      iconTheme: IconThemeData(color: Colors.black,size: 27),
        title: Text('Update your password',style: TextStyle(
              fontSize: 23,fontFamily: 'Neue_Plak',
              color: Colors.black,
            )),),
      body: Column(
        children: [
          
            Container(
              width: 600,
              height: 30.0,
              color: Color.fromARGB(255, 243, 224, 51),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_clock),
                    Text(
                      'For your security, this link expires in half an hour',
                      style: TextStyle(
                        fontSize: 12.0,
                        //fontWeight: ,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 100.0),
            CircleAvatar(
              backgroundColor: Colors.grey[200],
              radius: 50.0,
              child: Icon(
                Icons.lock,
                size: 50.0,
              ),
            ),
              
           
            Text('Check your email to update\n                 your password',style: TextStyle(
            fontSize: 16,fontFamily: 'Neue_Plak',
            color: Colors.black,
            )),
            SizedBox(height: 20.0),
          ElevatedButton(
            child: Text('Open Gmail'),
            onPressed: () {
            launchUrlString('mailto:');
            },
          ),
        ],
      ),
    );
  }
}
