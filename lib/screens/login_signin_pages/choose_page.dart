// import 'package:event_brite_app/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import '../../reusable_widgets/log_in_button.dart';
import 'email2.dart';
import 'emailval.dart';
import 'entering_email_page.dart';
import 'face.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../constants.dart';
import '../../reusable_widgets/log_out_button.dart';
import 'GoogleSignIn.dart';
import 'Logging.dart';

class ChooseCustomerOrOrganiserPage extends StatelessWidget {
  const ChooseCustomerOrOrganiserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //   body: Column(
    //     children: [
    //       Text('Continue As a....'),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Container(
    //             height: 100,
    //             width: 100,
    //             child: Text('Client'),
    //           ),
    //           Container(
    //             height: 100,
    //             width: 100,
    //             child: Text('Organiser'),
    //           )
    //         ],
    //       )
    //     ],
    //   ),
    // );
  // }
//}
     
     //backgroundColor: Colors.orangeAccent,
     body: Center(
       child: Container(
        decoration: BoxDecoration(
          gradient:LinearGradient(colors: [
            secondaryColor,
            Colors.orange,
            Colors.purpleAccent,
            Color.fromARGB(255, 77, 1, 91),
          ],
          // stops: [
          //   0.4,0.6,0.6,0.8
          // ],
          
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,) ),
          child: Center(
            child: Column(
            children: [
              Text('Continue As a....'),
              Center(
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Text('Client'),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Text('Organiser'),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
                   ),
          ),
         ),
     ),);
  }
}