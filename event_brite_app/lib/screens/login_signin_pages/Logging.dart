import 'package:event_brite_app/screens/login_signin_pages/GoogleSignIn.dart';
import 'package:event_brite_app/screens/login_signin_pages/log_in_page2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_sign_in/google_sign_in.dart';

class  LoggedInPage extends StatelessWidget {
  //const LoggedInPage({super.key});
  final GoogleSignInAccount user;
  LoggedInPage({
    Key? key,
    required this.user,
  }) :super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       
      body: Column(
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
            'Name: '+user.displayName!
,          ),
          Text(
            'Email: '+user.email
,          )

        ],
      ),
    );
  }
}