import 'package:flutter/material.dart';


/// This custom coulmn is used in profile page
class CustomColumn extends StatelessWidget {
  const CustomColumn({super.key, required this.text});
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
