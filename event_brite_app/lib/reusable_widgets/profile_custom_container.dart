import 'package:flutter/material.dart';

import '../../screens/settings_screen/settings_screen.dart';

class ProfileSettingsContainer extends StatelessWidget {
  const ProfileSettingsContainer(
      {super.key,
      @required this.icon,
      required this.text,
      @required this.sizedBoxWidth});
  final IconData? icon;
  final String? text;
  final double? sizedBoxWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .06,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon),
              SizedBox(
                width: sizedBoxWidth,
              ),
              Text(
                text!,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Opacity(
            opacity: 0.5,
            child: IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_right,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
