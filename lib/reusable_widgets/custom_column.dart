// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';



class CustomColumn extends StatelessWidget {
  const CustomColumn({key, required this.text});
  /// text for profile page can take values of (My tickets, Following, Likes)
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '0',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text!,
          style: const TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 65, 62, 243),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
