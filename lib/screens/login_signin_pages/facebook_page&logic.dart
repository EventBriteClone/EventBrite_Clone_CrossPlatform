import 'dart:convert';

import 'package:event_brite_app/constants.dart';
import 'package:event_brite_app/reusable_widgets/final_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart';

import '../../reusable_widgets/neu.dart';
import '../../reusable_widgets/neumorphic_button.dart';
import 'choose_organiser_or_attendee.dart';
import '../../reusable_widgets/final_button.dart';

class MyFaceApp extends StatefulWidget {
  const MyFaceApp({Key? key}) : super(key: key);

  @override
  State<MyFaceApp> createState() => _MyFaceAppState();
}

class _MyFaceAppState extends State<MyFaceApp> {
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool _checking = true;
  ///
   bool _isLoading = false;
   String _errorMessage = '';
  void login(String email , password) async {
    
    try{
      //email='joe@gmail.com';
      Response response = await post(
        Uri.parse('https://event-us.me:8000/user/login/'),
        body: {
          'email' : email+'1',
          'password' : password+'1'
        }
      );

      if(response.statusCode == 200){
        
        var data = jsonDecode(response.body.toString());
        print("token"+data['token']);
        print('Login successfully');
        Navigator.push(context,MaterialPageRoute(builder:(context){
                                     return CchooseCustomerOrOrganiserPage();
        
}));
      }else {
        print('failed');
      }
    }catch(e){
      print('ypussef');
      print(e.toString());
    }
  } 
  Future<void> _signup() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final url = 'https://event-us.me:8000/user/signup/';
    final response = await post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'email':_userData!['email'].toString()+'1',
        'first_name':_userData!['email'].toString(),
        'last_name': _userData!['email'].toString(),
        'password':_userData!['email'].toString()+'1',
      }),
      
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 201) {
      // Handle successful sign up here.
        //var data = jsonDecode(response.body.toString());
        //print("token"+data['token']);
        print('SignUp successfully');
        login(_userData!['email'].toString(),_userData!['email'].toString());
    } else {
      setState(() {
        _errorMessage = 'Failed to sign up. Please try again.';
      });
    }
  }   
      void val(String email) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try{
      email=email+'1';
      print(email);
      final response = await get(Uri.parse('https://event-us.me:8000/user/emailcheck/$email'));
        
      

      if(response.statusCode == 200){
        print('youssef200');
        final json = jsonDecode(response.body);
        if (json['email_exists'] == true) {
          //setState(() {
            //_responseValue = true;
            //_isLoading = false;
            setState(() {
      _isLoading = false;
      _errorMessage = '';
    });   
            print ('mwgood');
              login(_userData!['email'].toString(),_userData!['email'].toString());  
          }
          else{
            setState(() {
      _isLoading = false;
      _errorMessage = '';
    });     
     print('msh');
              _signup();
           
          }
       


      }else {
        print('failed');
                    
        
      }
    }catch(e){
      print('ypussef');
      print(e.toString());
    }
  }
  ///
  ////
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkIfisLoggedIn();
  }

  _checkIfisLoggedIn() async {
    final accessToken = await FacebookAuth.instance.accessToken;

    setState(() {
      _checking = false;
    });

    if (accessToken != null) {
      print(accessToken.toJson());
      final userData = await FacebookAuth.instance.getUserData();
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    } else {
      _login();
    }
  }

  _login() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
    } else {
      print(result.status);
      print(result.message);
    }
    setState(() {
      _checking = false;
    });
  }

  _logout() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(_userData);
    return MaterialApp(
      home: Scaffold(
        appBar:AppBar(backgroundColor: Colors.white,
      shadowColor: Colors.grey,
      iconTheme: IconThemeData(color: Colors.black,size: 27),
        title: Text('Log in with Facebook',style: TextStyle(
              fontSize: 27,fontFamily: 'Neue Plak',
              color: Colors.black,
            )),),
        body: _checking
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _userData != null
                      ? Text('name: ${_userData!['name']}')
                      : Container(),
                  _userData != null
                      ? Text('email: ${_userData!['email']}')
                      : Container(),
                  _userData != null
                      ? Container(
                          child: Image.network(
                              _userData!['picture']['data']['url']),
                        )
                      : Container(),
                  SizedBox(
                    height: 20,
                  ),
                  Neumorphic(
                    style: NeumorphicStyle(
        color: Colors.white70,
        shape: NeumorphicShape.flat,
        depth: 8,
        intensity: 0.8,
        lightSource: LightSource.topLeft,
      ),
                    child: CupertinoButton(color: Colors.white70,
                        child: Text(
                          _userData != null ? 'LOGOUT' : 'LOGIN',
                          style: TextStyle(color: secondaryColor),
                        ),
                        onPressed: _userData != null? _logout :
                        _login
                       
                                //};
                         ),
                  ),

Container(
  height: 350,
  child:   Column(
    mainAxisAlignment:MainAxisAlignment.end,
    children:   [Padding(
      padding: const EdgeInsets.all(8.0),
      child: finalCustomButton(
      onTap: _isLoading? (){ //:() {
          null;
          // Do something when the button is pressed
        
        }:(){
          val(_userData!['email'].toString());
        },
       child: _isLoading
                            ? SizedBox(
                              width: 10,
                              child: CircularProgressIndicator(strokeWidth: 2,
                              color:Colors.white24))
                            : Center(child: Text('Continue through our application',style: TextStyle(color: secondaryColor,fontSize: 20,fontWeight:FontWeight.bold),)),
        backgroundColor:secondaryColor,
      ),
    ),]
  ),
),
  //backgroundColor: backgroundColor)
                ],
              )),
      ),
    );
  }
}