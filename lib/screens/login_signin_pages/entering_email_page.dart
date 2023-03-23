import '../../constants.dart';
import '../../reusable_widgets/custom_text_field.dart';
import '../../reusable_widgets/log_out_button.dart';
import 'entering_password.dart';
import 'sign_up_page.dart';
import 'valide.dart';
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
              fontSize: 27,fontFamily: 'Neue Plak',
              color: Colors.black,
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
           LogOutButton(
            //imgFlag: false,
            text: 'button if the user is going to log in \n (will be changed later)',
            onTap: ()
                        {
                          if (EmailformKey.currentState!.validate()) {
       Navigator.push(context,MaterialPageRoute(builder:(context){
         return EnteringPassword();
       }));
     }
     else{
     
     }
                        }),
            
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
                                     icon: null,
                                     sizedBoxWidth: null,
                                     //image: null,
                                     //imgFlag: false,
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