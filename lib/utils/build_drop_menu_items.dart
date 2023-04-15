import 'package:flutter/material.dart';

/// Builds a dropdown menu item for the given [item] string.

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: const TextStyle(fontSize: 18, fontFamily: "Poppins"),
    ));
