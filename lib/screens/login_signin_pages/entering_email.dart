// import 'package:event_brite_app/constants.dart';
// import 'package:event_brite_app/reusable_widgets/log_out_button.dart';
 import 'package:event_brite_app/screens/login_signin_pages/entering_password.dart';
import 'package:event_brite_app/screens/login_signin_pages/signApi.dart';

import 'entering_password.dart';
import 'sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../../constants.dart';
import '../../reusable_widgets/log_out_button.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';


class EmailValidationScreen extends StatefulWidget {
  @override
  _EmailValidationScreenState createState() => _EmailValidationScreenState();
}

class _EmailValidationScreenState extends State<EmailValidationScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isButtonEnabled = false;
  void val(String email) async {
    
    try{
      
      Response response = await post(
        Uri.parse('http://34.235.157.174:8000/user/emailCheck/'),
        
        body: {
          'email' : email,
          //'password' : '512002joee'
        }
      );

      if(response.statusCode == 200){
        print('200');
        var data = jsonDecode(response.body.toString());
        //if (data['exits']==false)
        //{
        //print("exits"+data['exits']);
        Navigator.push(context,MaterialPageRoute(builder:(context){
                                       return SignUpPage(text:_emailController.text);
                                  }));      
        //}
        //print("token"+data['token']);
        //print('Login successfully');

      }else {
        print('failed');
        Navigator.push(context,MaterialPageRoute(builder:(context){
                                       return PasswordPage(text:_emailController.text);
                                  //return SignUpScreen();
                                  }));   
      }
    }catch(e){
      print('ypussef');
      print(e.toString());
    }
  }
  void _checkEmailValidation() {
    setState(() {
      _isButtonEnabled = EmailValidator.validate(_emailController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      //resizeToAvoidBottomPadding:
      appBar: AppBar(backgroundColor: Colors.white,
      shadowColor: Colors.grey,
      iconTheme: IconThemeData(color: Colors.black,size: 27),
        title: Text('Log in or sign in',style: TextStyle(
              fontSize: 27,fontFamily: 'Neue Plak',
              color: Colors.black,
            )),),
      
     body: Column(
       children: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                ),
                onChanged: (value) => _checkEmailValidation(),
              ),

         ),
         SizedBox(height: 50,),
         
          
            //SizedBox(height: 250,),
     
                 Expanded(
                   child: Container(
                    
                    constraints: BoxConstraints(minHeight: 200),
                     child: Column(
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
                             child: Container(
                              decoration: BoxDecoration(
            color: _isButtonEnabled ? primaryColor : Color.fromARGB(255, 97, 95, 95),
            
          ),

                               child: LogOutButton(
                                           onTap: _isButtonEnabled
                                                ? (){
                val(_emailController.text.toString());
              }
          //{
            //                                           setState(() {
            // _isButtonEnabled = !_isButtonEnabled;
          //});
          //                                        Navigator.push(context,MaterialPageRoute(builder:(context){
          //                             return SignUpPage(text:_emailController.text);
          //                           }));
          //                                          // do something when button is pressed
          //                                        }
                                               : null,
                                           text: 'Next',
                                         ),
                             ),
                           ),
                         ),
      //                    Container(
      //                     decoration: BoxDecoration(
      //                       color: Colors.white,
      //                       boxShadow: [
      //                         BoxShadow(
      //                           color: Colors.grey,
      //                           blurRadius: 5,
      //                           //offset: Offset(0,-4)
      //                         )
      //                       ] 
      //                     ),
      //                      child: Padding(
      //                        padding: const EdgeInsets.all(8.0),
      //                        child: Container(
      //                         decoration: BoxDecoration(
      //       color: _isButtonEnabled ? primaryColor : Color.fromARGB(255, 97, 95, 95),
            
      //     ),

      //                          child: LogOutButton(
              
      //         onTap: _isButtonEnabled?  () {
      //           //setState(() {
      //     //   _isButtonEnabled = !_isButtonEnabled;
      //     // });
      //               Navigator.push(context,MaterialPageRoute(builder:(context){
      //    return PasswordPage(text:_emailController.text);
      //  }));
      //                 // do something when button is pressed
      //               }
      //             : null,
      //         text: 'Next for sign in (will be changed later)',
      //       ),
      //                        ),
      //                      ),
      //                    ),
                       ],
                     ),
                   
                   ),
                 ),
     
                 
       ],
               
     ),
    );
  }
}
