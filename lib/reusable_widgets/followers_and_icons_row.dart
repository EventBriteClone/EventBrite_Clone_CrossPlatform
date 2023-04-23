// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FollowersAndIconsRow extends StatelessWidget {
  const FollowersAndIconsRow({key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          FontAwesomeIcons.user,
          size: 12,
        ),
        const SizedBox(
          width: 4,
        ),
        const Text('33 creator followers'),
        const SizedBox(
          width: 17,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.share,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            FontAwesomeIcons.heart,
            size: 18,
          ),
        ),
      ],
    );
  }
}
