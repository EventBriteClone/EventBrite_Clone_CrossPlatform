import 'package:event_brite_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
CustomButton({this.onTap,required this.text}) ;
VoidCallback? onTap;
String text; 
  @override
  Widget build(BuildContext context) {
    return GestureDetector 
    (
      onTap: onTap,
      child: Container(
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(8),
                    ),
                  width: double.infinity,
                  height: 60,
                  child: Center(child: Text(text,
                  style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold,fontSize: 16),))
                  ),
    );
  }
}