import 'dart:convert';

import 'package:http/http.dart';

import 'choose_organiser_or_attendee.dart';
import 'google_logic.dart';
import 'log_in_page2.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class  LoggedInPage extends StatefulWidget {
  //const LoggedInPage({super.key});
  final GoogleSignInAccount user;
  LoggedInPage({
    Key? key,
    required this.user,
  }) :super(key: key);

  @override
  State<LoggedInPage> createState() => _LoggedInPageState();
}

class _LoggedInPageState extends State<LoggedInPage> {
  bool _isLoading = false;
   String _errorMessage = '';
  void login(String email , password) async {
    
    try{
      //email='joe@gmail.com';
      Response response = await post(
        Uri.parse('https://event-us.me/user/login/'),
        body: {
          'email' : email,
          'password' : password
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

    final url = 'https://event-us.me/user/signup/';
    final response = await post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'email':widget.user.email,
        'first_name': widget.user.email,
        'last_name': widget.user.email,
        'password': widget.user.email,
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
        login(widget.user.email.toString(), widget.user.email.toString());
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
      
      Response response = await post(
        Uri.parse('https://event-us.me/user/emailCheck/'),
        
        body: {
          'email' : email,
          //'password' : '512002joee'
        }
      );

      if(response.statusCode == 200){
        print('200');
        var data = jsonDecode(response.body.toString());
        //if (data['exits']==false)
        {
        //print("exits"+data['exits']);
            setState(() {
      _isLoading = false;
      _errorMessage = '';
    });     
        _signup();
        

        }
        //print("token"+data['token']);
        //print('Login successfully');

      }else {
        print('failedd');
                    setState(() {
      _isLoading = false;
      _errorMessage = '';
    });     
        login(widget.user.email.toString(), widget.user.email.toString());
      }
    }catch(e){
      print('ypussef');
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(backgroundColor: Colors.white,
      shadowColor: Colors.grey,
      iconTheme: IconThemeData(color: Colors.black,size: 27),
        title: Text('Sign in with Google',style: TextStyle(
              fontSize: 27,fontFamily: 'Neue Plak',
              color: Colors.black,
            )),),
       
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: () async{
                await GoogleSignInApi.logout();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context)=>LogInPage2()
                  ));
            }
            , child: Text('Log out'))
            ,CircleAvatar(
              radius: 40,
              //backgroundImage: NetworkImage(user.photoUrl),
            ),
            Text(
              'Name: '+widget.user.displayName!
      ,          ),
            Text(
              'Email: '+widget.user.email
      ,          )
      ,ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                    //onTap: _isButtonEnabled
                      //?null
                      //: (){
                val(widget.user.email);
              //};
                        },
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Text('Sign Up'),
                ),
          ],
        ),
      ),
    );
  }
}