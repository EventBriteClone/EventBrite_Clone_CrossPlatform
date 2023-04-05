import '../constants.dart';
import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  CustomTextField({this.hintText,this.TitleText,this.onChanged,this.obsccureText=false,@required this.suffix=null});
  String? hintText;
  String? TitleText;
  bool? obsccureText;
  IconData? suffix;
  Function(String)? onChanged;
  //Function suffixPressed;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
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