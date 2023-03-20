import 'package:flutter/material.dart';

class CustomSettingsContainer extends StatelessWidget {
  const CustomSettingsContainer({super.key, required this.text});

  final String? text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.07,
        child: Text(
          text!,
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
    );
  }
}
