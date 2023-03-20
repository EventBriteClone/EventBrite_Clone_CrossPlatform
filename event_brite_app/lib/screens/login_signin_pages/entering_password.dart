import 'package:event_brite_app/reusable_widgets/custom_Text_field.dart';
import 'package:event_brite_app/reusable_widgets/profile_custom_container.dart';
import 'package:event_brite_app/screens/login_signin_pages/choose_page.dart';
import 'package:event_brite_app/screens/login_signin_pages/entering_email_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../reusable_widgets/log_in_button.dart';
import '../../reusable_widgets/log_out_button.dart';
import 'chosse2.dart';

class EnteringPassword extends StatelessWidget {
  EnteringPassword({Key? key}):super(key:key);
static String id='RegisterPage';
String?password;  
bool isPassword=true;
GlobalKey<FormState> formKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
      shadowColor: Colors.grey,
      iconTheme: IconThemeData(color: Colors.black,size: 27),
        title: Text('Log in or sign in',style: TextStyle(
              fontSize: 32,fontFamily: 'Albertus Extra Bold',
              color: Colors.black,fontWeight: FontWeight.w900,
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
                  const Center(
                    child: Opacity(
                      opacity: 0.8,
                      child: Text(
                        'youssefsaadlotfy73@gmail.com',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EnteringEmail();
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
                    child: CustomTextField(
                      TitleText: 'Password*',
                      suffix:Icons.remove_red_eye,
                                 
                      obsccureText: isPassword,
                      hintText: 'Enter Password',
                    ),
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
                                                       Navigator.push(context,MaterialPageRoute(builder:(context){
                                    return CchooseCustomerOrOrganiserPage();
                                                       }));
                                                     }
                                                     else{
                                                     
                                                     }
                                    },
                                                       text:'Log in',
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:8),
                                                    child: LogOutButton(
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