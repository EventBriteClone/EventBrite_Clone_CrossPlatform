import 'google_logic.dart';
import 'log_in_page2.dart';
import 'package:flutter/material.dart';
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
              'Name: '+user.displayName!
      ,          ),
            Text(
              'Email: '+user.email
      ,          )
      
          ],
        ),
      ),
    );
  }
}