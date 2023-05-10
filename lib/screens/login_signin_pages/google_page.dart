import 'dart:convert';

import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/token_provider.dart';
import '../../reusable_widgets/final_button.dart';
import 'choose_organiser_or_attendee.dart';
import 'google_logic.dart';
import 'log_in_page2.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoggedInPage extends StatefulWidget {
  //const LoggedInPage({super.key});
  final GoogleSignInAccount user;
  LoggedInPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<LoggedInPage> createState() => _LoggedInPageState();
}

class _LoggedInPageState extends State<LoggedInPage> {
  bool _isLoading = false;
  String _errorMessage = '';
    void gotochooseAndOrg() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CchooseCustomerOrOrganiserPage();
    }));
  }
  Future login(String email, password) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try {
      //email='joe@gmail.com';
      Response response = await post(
          Uri.parse('https://event-us.me:8000/user/login/'),
          body: {'email': email + '5', 'password': password + '5'});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        String token = data['token'].toString();
        print("token" + data['token']);
        print('Login successfully');
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return CchooseCustomerOrOrganiserPage();
       // }));
       gotochooseAndOrg();
       setState(() {
      _isLoading = false;
      _errorMessage = '';
    });
    return token;
      } else {
        print('failed');
      }
    } catch (e) {
      print('ypussef');
      print(e.toString());
    }
    return "error";
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
        'email': widget.user.email.toString() + '5',
        'first_name': widget.user.email.toString(),
        'last_name': widget.user.email.toString(),
        'password': widget.user.email.toString() + '5',
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
               var token= login(widget.user.email.toString(), widget.user.email.toString());
         await Future.delayed(const Duration(seconds: 5));
         token.then((value) {
                                  String sad = value;
                                  print('token here: ' + value);
                                  if (value=='error')
                                  {
                                        setState(() {
      _isLoading = false;
      _errorMessage = 'Password is not correct';
    });
                                  
                                    print('hey error');
                                  }
  Provider.of<TokenModel>(context, listen: false).setToken(value);
  

                                  //authTokenProvider.setToken(AuthToken(sad));
                                  // prints "Hello, World!"
                                });
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
    try {
      email = email + '5';
      final response = await get(
          Uri.parse('https://event-us.me:8000/user/emailcheck/$email/'));

      if (response.statusCode == 200) {
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
          print('mwgood');
         var token= login(widget.user.email.toString(), widget.user.email.toString());
         await Future.delayed(const Duration(seconds: 5));
         token.then((value) {
                                  String sad = value;
                                  print('token here: ' + value);
                                  if (value=='error')
                                  {
                                        setState(() {
      _isLoading = false;
      _errorMessage = 'Password is not correct';
    });
                                  
                                    print('hey error');
                                  }
  Provider.of<TokenModel>(context, listen: false).setToken(value);
  

                                  //authTokenProvider.setToken(AuthToken(sad));
                                  // prints "Hello, World!"
                                });

        } else {
          setState(() {
            _isLoading = false;
            _errorMessage = '';
          });
          print('msh');
          _signup();
        }
      } else {
        print('failed');
      }
    } catch (e) {
      print('ypussef');
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        iconTheme: IconThemeData(color: Colors.black, size: 27),
        title: Text('Sign in with Google',
            style: TextStyle(
              fontSize: 27,
              fontFamily: 'Neue Plak',
              color: Colors.black,
            )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () async {
                  await GoogleSignInApi.logout();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LogInPage2()));
                },
                child: Text('Log out')),
            CircleAvatar(
              radius: 40,
              //backgroundImage: NetworkImage(user.photoUrl),
            ),
            Text(
              'Name: ' + widget.user.displayName!,
            ),
            Text(
              'Email: ' + widget.user.email,
            )
            // ,ElevatedButton(
            //             onPressed: _isLoading
            //                 ? null
            //                 : () {
            //               //onTap: _isButtonEnabled
            //                 //?null
            //                 //: (){
            //           val(widget.user.email);
            //         //};
            //                   },
            //             child: _isLoading
            //                 ? CircularProgressIndicator()
            //                 : Text('Sign Up'),
            //           ),
            ,
            Container(
              height: 350,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: finalCustomButton(
                    onTap: _isLoading
                        ? () {
                            //:() {
                            null;
                            // Do something when the button is pressed
                          }
                        : () {
                            val(widget.user.email);
                            //val(_userData!['email'].toString());
                          },
                    child: _isLoading
                        ? SizedBox(
                            width: 10,
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: primaryColor,
                              ),
                            ))
                        : Center(
                            child: Text(
                            'Continue through our application',
                            style: TextStyle(
                                color: secondaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                    backgroundColor: secondaryColor,
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
