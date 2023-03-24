// import 'package:event_brite_app/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class ChooseCustomerOrOrganiserPage extends StatelessWidget {
  const ChooseCustomerOrOrganiserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              secondaryColor,
              Colors.orange,
              Colors.purpleAccent,
              Color.fromARGB(255, 77, 1, 91),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          )),
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
                          child: SizedBox(
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
      ),
    );
  }
}
