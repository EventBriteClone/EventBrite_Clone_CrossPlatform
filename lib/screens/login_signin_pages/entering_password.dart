import 'package:event_brite_app/screens/login_signin_pages/forget.dart';
import 'package:event_brite_app/screens/login_signin_pages/gmail.dart';
import 'package:flutter/material.dart';
import 'package:event_brite_app/screens/login_signin_pages/entering_email.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/token_provider.dart';
import '../../reusable_widgets/custom_Text_field.dart';
//import 'entering_email_page.dart';
import 'package:flutter/material.dart';
import '../../reusable_widgets/log_in_button.dart';
import '../../reusable_widgets/log_out_button.dart';
import '../home_page/home_screen.dart';
import 'choose_organiser_or_attendee.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';

class PasswordPage extends StatefulWidget {
  final String text;

  PasswordPage({required this.text});
  bool _isLoading = false;
  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  TextEditingController passwordController = TextEditingController();
  String displayText = '';
  bool _passwordVisible = false;
  static String id = 'RegisterPage';
  String? password;
  bool isPassword = true;
  bool _obscureText = true;
  bool _isLoading = false;
  String _errorMessage = '';

  GlobalKey<FormState> formKey = GlobalKey();
  void gotochooseAndOrg() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CchooseCustomerOrOrganiserPage();
    }));
  }

  void val(String email) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try {
      final response = await get(
          Uri.parse('https://event-us.me:8000/user/reset-password/$email/'));

      if (response.statusCode == 200) {
        print('youssef200');
        final json = jsonDecode(response.body);
        if (json['email_exists'] == true) {
          print('email sent');
          //setState(() {
          //_responseValue = true;
          //_isLoading = false;
          setState(() {
            _isLoading = false;
            _errorMessage = '';
          });
          print('mwgood');
        } else {
          setState(() {
            _isLoading = false;
            _errorMessage = '';
          });

          //return SignupPagee();

          print('msh');
        }
      } else {
        print('failed');
      }
    } catch (e) {
      print('ypussef');
      print(e.toString());
    }
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
          body: {'email': email, 'password': password});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        String token = data['token'].toString();
        print("token:" + data['token']);
        print('Login successfully');
        print('asdasd' + token);
                                gotochooseAndOrg();

         setState(() {
      _isLoading = false;
      _errorMessage = '';
    });
        return token;
      } else {
        print('failed');
        _errorMessage='Password is not correct';
        //return ('sadasd');
      }
    } catch (e) {
      print('ypussef');
      print(e.toString());
    }
    return "error";
  }

  @override
  void initState() {
    super.initState();
    displayText = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    //final authTokenProvider =
        //Provider.of<AuthTokenProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        iconTheme: IconThemeData(color: Colors.black, size: 27),
        title: Text('Log in or sign in',
            style: TextStyle(
              fontSize: 27, fontFamily: 'Neue Plak',
              color: Colors.black, //fontWeight: FontWeight.w900,
            )),
      ),
      body: Form(
        key: formKey,
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          const CircleAvatar(
            backgroundColor: Colors.red,
            radius: 35,
            //backgroundImage: AssetImage(
            //'assets/images/Eventbrite_logo.png',
            //),
          ),
          const SizedBox(
            height: 12,
          ),

          const SizedBox(
            height: 3,
          ),
          Center(
            child: Opacity(
              opacity: 0.8,
              child: Text(
                displayText,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          GestureDetector(
            key:ValueKey("Change Text in Password page"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return EmailValidationScreen();
                }));
              },
              child: Text(
                'Change',
                style: TextStyle(
                    color: Color.fromRGBO(54, 89, 227, 1),
                    fontWeight: FontWeight.w500),
              )),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: passwordController,
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  child: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            
//                     child:TextFormField(
//   obscureText: _obscureText, // show/hide password based on state variable
//   decoration: InputDecoration(
//     labelText: 'Password',
//     suffixIcon: GestureDetector(
//       onTap: () {
//         setState(() {
//           _obscureText = !_obscureText; // toggle state variable
//         });
//       },
//       child: Icon(
//         _obscureText ? Icons.visibility_off : Icons.visibility,
//         semanticLabel: _obscureText ? 'Show password' : 'Hide password',
//       ),
//     ),
//   ),
// ),
          ),
          Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
          //SizedBox(height: 40,),
          Expanded(
            child: Container(
              constraints: BoxConstraints(minHeight: 200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        //offset: Offset(0,-4)
                      )
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          CustomButton(
                            key:ValueKey("login Button"),
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                              var token;
                                try {
  var token = login(displayText.toString(),
      passwordController.text.toString());
      await Future.delayed(
                                    const Duration(seconds: 5));

                                print('wwww');
                                print(token);
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
} catch (e) {
  print(e.toString());
  // TODO
}
                                //String token = "your_token_value";
                                

                                print('ada');
                                print(token);
                              } else {}
                            },
                            child:_isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Center(child: Text('Login',style: TextStyle(color: primaryColor),)),
                ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              key:ValueKey("I forgot my password text"),
                              onTap: () {
                                //val(displayText.toString());
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return GmailPage();
                                }));
                              },
                              child: Text(
                                '    I forgot my password',
                                style: TextStyle(
                                    color: Color.fromRGBO(54, 89, 227, 1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
