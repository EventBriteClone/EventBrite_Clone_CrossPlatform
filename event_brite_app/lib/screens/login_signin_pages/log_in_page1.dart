import 'package:event_brite_app/screens/home_page/search_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../reusable_widgets/log_in_button.dart';
import 'log_in_page2.dart';

class LogInPage1 extends StatelessWidget {
  const LogInPage1({super.key});
  //VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
     
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12,top: 40),
            child: Text('See your favourites\nin one place',
                style: TextStyle(
                  //decorationThickness: 500,
                  fontSize: 32,
                  fontFamily: 'Neue Plak',
                  color: Colors.black,
                  fontWeight: FontWeight.w200,
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              'Log in to see your favourites',
              style: TextStyle(),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left:12.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SearchScreen();
                  }));
                },
                child: Text(
                  'Explore events',
                  style: TextStyle(
                      color: Color.fromRGBO(54, 89, 227, 1), fontWeight: FontWeight.w500),
                )),
          ),
          SizedBox(
            height: 125,
          ),
          Stack(
            children: [
              Container(
                height: 350,
                //width: 900,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image(
                      image:AssetImage('assets/images/Circle.jpeg'),
                      height: 400,
                    ),
                  ],
                ),
              ),
              //SizedBox(height: 200,),
              Column(
                children: [
                  Container(height: 270,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        
                        child: Padding(
                          padding: const EdgeInsets.only(right: 35,top: 60),
                          child: Icon(FontAwesomeIcons.heart,size: 180,color: Color.fromARGB(255, 181, 181, 181).withOpacity(0.2),),
                        )),
                    ],
                  )
                  ,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return LogInPage2();
                        }));
                      },
                      text: 'Log in',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
