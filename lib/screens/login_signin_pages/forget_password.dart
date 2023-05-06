import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:lottie/lottie.dart';

import '../../constants.dart';

class NewPasswordPage extends StatefulWidget {
  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  String newPassword = '';
  final TextEditingController controller = TextEditingController();
  bool success = false;
  late TextEditingController _textController;
  bool _isLoading = false;
  String _errorMessage = '';
  bool _isButtonNotEnabled = true;
    @override
 

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        iconTheme: IconThemeData(color: Colors.black, size: 27),
        title: Text(
          'New Password',
          style: TextStyle(
            fontSize: 23,
            fontFamily: 'Neue_Plak',
            color: Colors.black,
            //fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          //YoussscrossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  'You Forgot Your Password...',
                  style: TextStyle(fontSize: 20.0),
                ),
                Lottie.asset(
                  'assets/animations/dlf10_K5ZqzbCY6R.json',
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No Problem',
                  style: TextStyle(fontSize: 20.0),
                ),
                Lottie.asset(
                  'assets/animations/dlf10_U3zDvQCEfY.json',
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Enter your new Password',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
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
                         
                        },
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Text('Login',style: TextStyle(color: primaryColor),),
                ),
          ],
        ),
      ),
    );
  }
}
