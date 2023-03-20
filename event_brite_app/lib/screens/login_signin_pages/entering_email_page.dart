import 'package:event_brite_app/constants.dart';
import 'package:event_brite_app/reusable_widgets/custom_Text_field.dart';
import 'package:event_brite_app/reusable_widgets/log_out_button.dart';
import 'package:event_brite_app/screens/login_signin_pages/entering_password.dart';
import 'package:event_brite_app/screens/login_signin_pages/sign_up_page.dart';
import 'package:event_brite_app/screens/login_signin_pages/valide.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../reusable_widgets/log_in_button.dart';

class EnteringEmail extends StatelessWidget {
  EnteringEmail({super.key});
  GlobalKey<FormState> EmailformKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      //resizeToAvoidBottomPadding:
      appBar: AppBar(backgroundColor: Colors.white,
      shadowColor: Colors.grey,
      iconTheme: IconThemeData(color: Colors.black,size: 27),
        title: Text('Log in or sign in',style: TextStyle(
              fontSize: 32,fontFamily: 'Albertus Extra Bold',
              color: Colors.black,fontWeight: FontWeight.w900,
            )),),
      
     body: Form(
      key: EmailformKey,
       child: Column(
         children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: CustomTextField(
              TitleText: 'Email',
              hintText: "Enter email address",
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
                               child: LogOutButton(
                                     
                                     onTap: ()
                        {
                          if (EmailformKey.currentState!.validate()) {
       Navigator.push(context,MaterialPageRoute(builder:(context){
         return HomePagee();
       }));
     }
     else{
     
     }
                        },
                                     text:'Next',
                                   ),
                             ),
                           ),
                         ],
                       ),
                     
                     ),
                   ),
     
                   
         ],
                 
       ),
     ),
    );
  }
}