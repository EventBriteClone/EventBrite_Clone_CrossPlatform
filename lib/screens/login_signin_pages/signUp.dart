import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../constants.dart';
import 'choose_organiser_or_attendee.dart';
///here is the sign up page where the user has to write his name,last name, email addrerss to sign up
class SignupPagee extends StatefulWidget {
  final String text;
  SignupPagee({required this.text});
  @override
  _SignupPageeState createState() => _SignupPageeState();
}

class _SignupPageeState extends State<SignupPagee> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController controller = TextEditingController();
  bool success = false;
  late TextEditingController _textController;
  bool _isLoading = false;
  String _errorMessage = '';
    bool _isButtonNotEnabled = true;
  @override
  void _checkIfButtonEnabled() {
    setState(() {
      _isButtonNotEnabled =
          _textController.text.trim() != _emailController.text.trim();
    });
  }
   @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.text);
    _textController.addListener(_checkIfButtonEnabled);
    _emailController.addListener(_checkIfButtonEnabled);
  }
  ///here is a login function to to login after signup process
  void login(String email , password) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try{
      
      Response response = await post(
        Uri.parse('https://event-us.me:8000/user/login/'),
        body: {
          'email' : email,
          'password' : password
        }
      );
///if response =200 then the request is done
      if(response.statusCode == 200){
        
        var data = jsonDecode(response.body.toString());
        print("token"+data['token']);
        print('Login successfully');
        Navigator.push(context,MaterialPageRoute(builder:(context){
                                     return CchooseCustomerOrOrganiserPage();
           }));
            setState(() {
      _isLoading = false;
      _errorMessage = '';
    });

      }else {
        print('failed');
      }
    }catch(e){
      print('ypussef');
      print(e.toString());
    }
  }
  Future<void> _signup() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final url = 'https://event-us.me:8000/user/signup/';
    final response = await post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'email': _emailController.text,
        'first_name': _firstNameController.text,
        'last_name': _lastNameController.text,
        'password': controller.text,
      }),
      
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 201) {
      // Handle successful sign up here.
        //var data = jsonDecode(response.body.toString());
        //print("token"+data['token']);
        print('sign Up successfully');
        login(_emailController.text.toString(),controller.text.toString() );
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
        appBar: AppBar(backgroundColor: Colors.white,
      shadowColor: Colors.grey,
      iconTheme: IconThemeData(color: Colors.black,size: 27),
        title: Text('Sign Up',style: TextStyle(
              fontSize: 32,fontFamily: 'Albertus Extra Bold',
              color: Colors.black,fontWeight: FontWeight.w900,
            )),),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
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
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue) ),
            ),

                  controller: _textController,
                  enabled: false,
                 ),
                 SizedBox(height: 16,),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an email address.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your first name.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your last name.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // TextFormField(
                //   controller: _passwordController,
                //   obscureText: true,
                //   decoration: InputDecoration(
                //     labelText: 'Password',
                //   ),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Please enter a password.';
                //     }
                //     return null;
                //   },
                // ),
                SizedBox(
                    height: 220,
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
                          uppercaseCharCount: 1,
                          numericCharCount: 1,
                          specialCharCount: 1,
                          //normalCharCount: 3,
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
                //SizedBox(height: 16),
                ElevatedButton(
                  
                   style: ElevatedButton.styleFrom(
                    //minimumSize: Size.fromWidth(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  elevation: 8,
                  shadowColor: Colors.black.withOpacity(0.3),
                  // change the colors below to match your neumorphism design
                  primary: secondaryColor,
                  onPrimary: Colors.grey[900],
                ),
                  onPressed: _isLoading | _isButtonNotEnabled
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            _signup();
                          }
                        },
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Text('Sign Up',style: TextStyle(color: primaryColor),),
                ),
                SizedBox(height: 16),
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
