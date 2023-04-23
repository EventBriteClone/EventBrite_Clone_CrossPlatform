import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import '../../reusable_widgets/custom_text_field.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomePagee extends StatefulWidget {
  const HomePagee({Key? key}) : super(key: key);

  @override
  State<HomePagee> createState() => _HomePageState();
}

class _HomePageState extends State<HomePagee> {
  final TextEditingController controller = TextEditingController();
  bool success = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';
  Future<void> _signup() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    final url = 'https://event-us.me/user/signup/';
    final response = await post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'email': _emailController.text,
        'first_name': _firstNameController.text,
        'last_name': _lastNameController.text,
        'password': _passwordController.text,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 201) {
      // Handle successful sign up here.
      //var data = jsonDecode(response.body.toString());
      //print("token"+data['token']);
      print('Login successfully');
    } else {
      setState(() {
        _errorMessage = 'Failed to sign up. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.grey,
          iconTheme: IconThemeData(color: Colors.black, size: 27),
          title: Text('Sign Up',
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'Albertus Extra Bold',
                color: Colors.black,
                fontWeight: FontWeight.w900,
              )),
        ),
        body: ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextField(
                    TitleText: 'Email',
                    hintText: "Enter email address",
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  CustomTextField(
                    TitleText: 'Confirm Email*',
                    hintText: "Confirm Email",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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
                  SizedBox(height: 20),
                  SizedBox(
                    height: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: TextField(
                              controller: controller,
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 207, 207, 207),
                                    ),
                                  ),
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
