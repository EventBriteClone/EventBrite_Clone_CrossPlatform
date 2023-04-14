import '../constants.dart';
import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  //final TextEditingController controller;, required TextEditingController controller
  CustomTextField({this.hintText,this.TitleText,this.onChanged,this.controller,this.obsccureText=false,@required this.suffix=null,Key? key}): super(key: key);
  String? hintText;
  String? TitleText;
  bool? obsccureText;
  IconData? suffix;
  Function(String)? onChanged;
  TextEditingController? controller;
  //String? controller;
  //Controller
  //Function suffixPressed;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsccureText!,
      validator: (data)
      {
        if(data!.isEmpty)
        {
          return 'field is required';
        }
      },
      onChanged: onChanged,
      
            decoration: InputDecoration(
              suffixIcon: Icon(suffix),
              hintText: hintText,
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
                  labelText: TitleText,


            ),
          );
  }
}