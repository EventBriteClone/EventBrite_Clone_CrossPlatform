import 'package:flutter/material.dart';

class InterestsContainer extends StatefulWidget {
 const InterestsContainer({super.key, required this.text});
  final String? text;

  @override
  State<InterestsContainer> createState() => _InterestsContainerState();
}

class _InterestsContainerState extends State<InterestsContainer> {
  Color color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 100,
      width: 100,
      duration: const Duration(seconds: 2),
      curve: Curves.easeIn,
      child: Material(
        color: color,
        child: InkWell(
          child: Center(
            child: Text(
              widget.text!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 27,
              ),
            ),
          ),
          onTap: () {
            setState(
              () {
                color == Colors.black
                    ? color = const Color(0xff5784BA)
                    : color = Colors.black;
              },
            );
          },
        ),
      ),
    );
  }
}
