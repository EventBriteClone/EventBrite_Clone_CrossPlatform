import 'package:flutter/material.dart';

/// A widget that displays  heading of a section.
///
/// It has  a private  [_headingText] which is a  [String]
///
///  It takes a single required parameter, headingText, which is the text to be displayed.
class HeadingWidget extends StatelessWidget {
  /// Creates a new instance of [HeadingWidget].
  ///
  /// The [headingText] parameter specifies the text  heading to display.
  const HeadingWidget({
    Key? key,
    required String? headingText,
  })  : _headingText = headingText,
        super(key: key);

  final String? _headingText;

  ///This widget is built using a Text widget wrapped in a Padding widget to add some space around the text.
  ///
  ///The text style is set to use the Poppins font with a font size of 18.
  ///
  ///If the [_headingText] parameter is null, an empty string is displayed.
  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        _headingText ?? '',
        style: const TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, fontFamily: "Poppins"),
      ),
    );
  }
}

//"Basic Info"
