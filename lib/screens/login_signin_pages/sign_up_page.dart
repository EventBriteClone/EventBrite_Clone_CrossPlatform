import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import '../../constants.dart';
import '../../reusable_widgets/custom_text_field.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
class SignUpPage extends StatefulWidget {
  final String text;
  SignUpPage({required this.text});

  @override
  State<SignUpPage> createState() => _HomePageState();
}

class _HomePageState extends State<SignUpPage> {
  final TextEditingController controller = TextEditingController();
  bool success = false;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.text);
  }
  

/////////////////////////////////////
//@CodeWithFlexz on Instagram
//
//AmirBayat0 on Github
//Programming with Flexz on Youtube
/////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.white,
      shadowColor: Colors.grey,
      iconTheme: IconThemeData(color: Colors.black,size: 27),
        title: Text('Sign Up',style: TextStyle(
              fontSize: 32,fontFamily: 'Albertus Extra Bold',
              color: Colors.black,fontWeight: FontWeight.w900,
            )),),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 6.5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(
              
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                color: primaryColor,
              ))
,
              // border: OutlineInputBorder(
              //   borderSide: BorderSide(
              //   color: Color.fromARGB(255, 210, 26, 26),
              // )),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue) ),
            ),

                  controller: _textController,
                  enabled: false,
                 ),
                 SizedBox(height: 25,),
                  CustomTextField(
                  TitleText: 'Confirm Email*',
                  hintText: "Confirm Email",
                 ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly
                  ,children: [
                    Container(
                      width: 180,
                      child: CustomTextField(
                                  TitleText: 'First Name*',
                                  hintText: "Enter First Name",
                                 ),
                    ),
                 Container(
                  //decoration:BoxDecoration(color: Colors.black),
                  width: 180,
                   child: CustomTextField(
                    TitleText: 'Surname*',
                    hintText: "Enter surname",
                   ),
                 ),
                  ],

                 ),
                 SizedBox(height:20),
                  SizedBox(
                    height: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                              controller: controller,
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(255, 207, 207, 207),
                                          ),),
                                      //borderRadius: BorderRadius.circular(5)),
                                  floatingLabelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: success ? Colors.blue : Colors.red,
                                        ),
                                    //borderRadius: BorderRadius.circular(15),
                                  ),
                                  hintText: "Password",
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide()))),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        FlutterPwValidator(
                          controller: controller,
                          minLength: 8,
                          uppercaseCharCount: 2,
                          numericCharCount: 3,
                          specialCharCount: 1,
                          normalCharCount: 3,
                          width: 400,
                          height: 150,
                          onSuccess: () {
                            setState(() {
                              success = true;
                            });
                            print("MATCHED");
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Password is matched")));
                          },
                          onFail: () {
                            setState(() {
                              success = false;
                            });
                            print("NOT MATCHED");
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}