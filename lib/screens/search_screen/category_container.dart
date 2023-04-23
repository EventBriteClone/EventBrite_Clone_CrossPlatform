import 'package:flutter/material.dart';

class CategoryContainer extends StatefulWidget {
  CategoryContainer({super.key, required this.text});
  final String? text;
  @override
  State<CategoryContainer> createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {
  late Color containerColor = const Color.fromARGB(255, 241, 237, 237);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(
          () {
            containerColor = containerColor == Colors.blue
                ? const Color.fromARGB(255, 241, 237, 237)
                : Colors.blue;
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Opacity(
          opacity: 0.6,
          child: Text(
            widget.text!,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
