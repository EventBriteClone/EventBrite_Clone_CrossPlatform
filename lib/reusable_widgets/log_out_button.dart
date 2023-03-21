// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton(
      {key,
      this.containerColor,
      required this.text,
      @required this.icon,
      @required this.sizedBoxWidth});
      
  /// custom IconData and text to handle all login and log out buttons
  final Color? containerColor;
  final String? text;
  final IconData? icon;
  final double? sizedBoxWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
