import 'package:flutter/material.dart';

class LogOutButton extends StatelessWidget {
   LogOutButton(
      {this.onTap,
      this.onPressed,
      this.containerColor,
      required this.text,
      @required this.icon,
      @required this.sizedBoxWidth,
      });
  VoidCallback? onTap;
  final Color? containerColor;
  final String? text;
  final IconData? icon;
  final double? sizedBoxWidth;
  //VoidCallback? onTap;  
  VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      
      child: Container(

        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          color: containerColor,
          border: Border.all(
            color: const Color.fromARGB(255, 120, 118, 118),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color.fromARGB(255, 42, 81, 239),
            ),
            SizedBox(
              width: sizedBoxWidth,
            ),
            Center(
              child: Text(
                text!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
