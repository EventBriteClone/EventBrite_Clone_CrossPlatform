import 'package:flutter/material.dart';

class ButtonForCategoriesScreen extends StatefulWidget {
  const ButtonForCategoriesScreen({super.key, required this.text});
  final String? text;

  @override
  State<ButtonForCategoriesScreen> createState() =>
      _ButtonForCategoriesScreenState();
}

class _ButtonForCategoriesScreenState extends State<ButtonForCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedContainer(
        duration: const Duration(seconds: 2),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(),
        ),
        height: MediaQuery.of(context).size.height * 0.1,
        child: InkWell(
          child: Center(
            child: Text(
              widget.text!,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
