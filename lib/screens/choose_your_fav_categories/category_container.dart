import 'package:flutter/material.dart';

class InterestsContainer extends StatefulWidget {
  const InterestsContainer({super.key, required this.text});
  final String? text;

  @override
  State<InterestsContainer> createState() => _InterestsContainerState();
}

class _InterestsContainerState extends State<InterestsContainer> {
  Color color = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipOval(
        child: AnimatedContainer(
          height: 85,
          width: 25,
          duration: const Duration(seconds: 0),
          child: Material(
            color: color,
            child: InkWell(
              child: Center(
                child: Text(
                  widget.text!,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 21, 21, 21),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              onTap: () {
                setState(
                  () {
                    color == Colors.grey
                        ? color = const Color.fromARGB(255, 59, 56, 221)
                        : color = Colors.grey;
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
