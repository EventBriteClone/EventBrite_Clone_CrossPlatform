import 'package:flutter/material.dart';
import 'package:event_brite_app/screens/login_signin_pages/entering_email.dart';

import '../../constants.dart';
import '../../reusable_widgets/custom_Text_field.dart';
//import 'entering_email_page.dart';
import 'package:flutter/material.dart';
import '../../reusable_widgets/log_in_button.dart';
import '../../reusable_widgets/log_out_button.dart';
import 'choose_organiser_or_attendee.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
class PasswordPage extends StatefulWidget {
  final String text;
  
  PasswordPage({required this.text});


  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
TextEditingController passwordController = TextEditingController();
String displayText = '';
bool _passwordVisible = false;  
static String id='RegisterPage';
String?password;  
bool isPassword=true;
bool _obscureText = true;
bool _isLoading = false;
String _errorMessage = '';
GlobalKey<FormState> formKey=GlobalKey();
void login(String email , password) async {
     setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try{
      //email='joe@gmail.com';
      Response response = await post(
        Uri.parse('https://event-us.me:8000/user/login/'),
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
  @override
  void initState() {
    super.initState();
    displayText = widget.text;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
      shadowColor: Colors.grey,
      iconTheme: IconThemeData(color: Colors.black,size: 27),
        title: Text('Log in or sign in',style: TextStyle(
              fontSize: 27,fontFamily: 'Neue Plak',
              color: Colors.black,//fontWeight: FontWeight.w900,
            )),),
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
                      child: Text(displayText
                        ,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EmailValidationScreen();
                  }));
                },
                child: Text(
                  'Change',
                  style: TextStyle(
                      color: Color.fromRGBO(54, 89, 227, 1), fontWeight: FontWeight.w500),
                )),
                  SizedBox(height: 5,),
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
                  //SizedBox(height: 40,),
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(minHeight: 200),
                      
                       child:Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           Container(
                             decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5,
                                  //offset: Offset(0,-4)
                                )
                              ] 
                            ),
                             child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Column(
                                 children: [
                                   CustomButton(
                                                       onTap: ()
                                    {
                                       if (formKey.currentState!.validate()) {
                                login(displayText.toString(),
                                    passwordController.text.toString());
                              } else {}
                                                     
                                    },child:Center(child: Text( 'Log in', style: TextStyle(fontWeight:FontWeight.bold,color: primaryColor,fontSize: 17 ),)),
                      ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:8),
                                                    child: LogOutButton(
                                                      //imgFlag: false,
                                                                            text: 'Email Me a login link',
                                                                             //icon: icon,
                                                                              sizedBoxWidth: null),
                                                  ),
                                                  
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Text(
                                                   '    I forgot my password',
                                                   style: TextStyle(
                                                       color: Color.fromRGBO(54, 89, 227, 1),
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 16),
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