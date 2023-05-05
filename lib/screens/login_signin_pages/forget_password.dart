import 'package:flutter/material.dart';

class NewPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
      shadowColor: Colors.grey,
      iconTheme: IconThemeData(color: Colors.black,size: 27),
        title: Text('New Password',style: TextStyle(
              fontSize: 23,fontFamily: 'Neue_Plak',
              color: Colors.black,//fontWeight: FontWeight.w900,
            )),),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter your new password',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            TextField(
              obscureText: true, // hide the text entered by the user
              decoration: InputDecoration(
                hintText: 'New Password',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
