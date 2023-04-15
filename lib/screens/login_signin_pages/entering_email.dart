// import 'package:event_brite_app/constants.dart';
// import 'package:event_brite_app/reusable_widgets/log_out_button.dart';
 import 'package:event_brite_app/screens/login_signin_pages/entering_password.dart';
import 'package:event_brite_app/screens/login_signin_pages/logIn.dart';
import 'package:event_brite_app/screens/login_signin_pages/signUp.dart';

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
  bool _isLoading = false;
  String _errorMessage = '';
  
  get http => null;
//   void isEmailFound(String email) async {
//   final response = await get(Uri.parse('https://event-us.me:8000/user/emailcheck/$email'));
//   print('ggg');
//    if (response.statusCode == 200) {

//      final json = jsonDecode(response.body);
//         if (json['email_exists'] == true) {
//           //setState(() {
//             //_responseValue = true;
//             //_isLoading = false;
//             print ('mwgood');
//           }
//           else{
//             print('msh');
//           }
    
    
//   } else {
//     print('false');
//   }
// }
  void val(String email) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try{
      
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
             Navigator.push(context,MaterialPageRoute(builder:(context){
                                       return PasswordPage(text:_emailController.text);
                                  //return SignUpScreen();
                                  }));  
          }
          else{
            setState(() {
      _isLoading = false;
      _errorMessage = '';
    });     
             Navigator.push(context,MaterialPageRoute(builder:(context){
                                       return SignupPagee(text:_emailController.text);
                                  
                                  //return SignupPagee();
                                  }));   
            print('msh');
          }
       


      }else {
        print('failed');
                    
        
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
                             padding: const EdgeInsets.all(4.0),
                             child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                //color: Colors.grey
            //color: _isButtonEnabled ? primaryColor : Color.fromARGB(255, 97, 95, 95),
            
          ),
          
              child:Expanded(
                child: ElevatedButton(
                  
                  style: ElevatedButton.styleFrom(
                    //minimumSize: Size.fromWidth(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  elevation: 8,
                  shadowColor: secondaryColor.withOpacity(0.3),
                  // change the colors below to match your neumorphism design
                  primary: secondaryColor,
                  onPrimary: primaryColor,
                ),
                    onPressed:  _isButtonEnabled
                        ?  () {
                      //onTap: _isButtonEnable
                        //?null
                        //: (){
                      //isEmailFound(_emailController.text.toString());
                  val(_emailController.text.toString());
                //};
                          }:null,
                          
                          
                    child: _isLoading
                        ? CircularProgressIndicator()
                        : Text('Sign Up',style: TextStyle( fontWeight: FontWeight.bold ),),
                  ),
              ),
              //                  child: LogOutButton(
              //                              onTap: _isButtonEnabled
              //                                   ? (){
              //   val(_emailController.text.toString());
              // }
          
              //                                  : null,
              //                              text: 'Next',
              //                            ),
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
