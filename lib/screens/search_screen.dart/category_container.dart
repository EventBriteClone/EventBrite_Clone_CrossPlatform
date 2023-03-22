import 'package:flutter/material.dart';

class CategoryContainer extends StatefulWidget {
  const CategoryContainer({super.key, required this.text});
  final String? text;

  @override
  State<CategoryContainer> createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 241, 237, 237),
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
    );
  }
}
