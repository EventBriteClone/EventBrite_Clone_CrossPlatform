// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FollowersAndIconsRow extends StatefulWidget {
  FollowersAndIconsRow({key, this.isLiked});
  bool? isLiked;

  @override
  State<FollowersAndIconsRow> createState() => _FollowersAndIconsRowState();
}

class _FollowersAndIconsRowState extends State<FollowersAndIconsRow> {
  Color? lovedColor = Colors.red;
  Color? unLovedColors = Colors.white;

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
          onPressed: () {
            setState(() {
              widget.isLiked = !widget.isLiked!;
            });
          },
          icon: Icon(
            Icons.favorite,
            size: 20,
            color: widget.isLiked! ? Colors.red : null,
          ),
        ),
      ],
    );
  }
}
