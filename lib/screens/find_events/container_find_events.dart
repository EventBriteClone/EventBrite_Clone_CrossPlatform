// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ContainerFindEvents extends StatelessWidget {
  const ContainerFindEvents(
      {key,
      required this.text,
      required this.subText,
      required this.icon});
  final String? text;
  final String? subText;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 193, 220, 244),
                shape: BoxShape.circle),
            child: Icon(
              icon!,
              size: 22,
              color: const Color.fromARGB(255, 34, 105, 163),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text!,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 39, 110, 168),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subText!,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
