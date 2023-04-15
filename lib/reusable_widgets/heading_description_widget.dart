import 'package:flutter/material.dart';

/// A widget that displays  description text.
///
/// It has  a private  [_headingDescText] which is a  [String]
///
///  It takes a single required parameter, headingDescText, which is the text to be displayed.
class HeadingDescriptionWidget extends StatelessWidget {
  /// Creates a new instance of [HeadingDescriptionWidget].
  ///
  /// The [headingDescText] parameter specifies the text to display.
  const HeadingDescriptionWidget({
    Key? key,
    required String? headingDescText,
  })  : _headingDescText = headingDescText,
        super(key: key);

  final String? _headingDescText;

  ///This widget is built using a Text widget wrapped in a Padding widget to add some space around the text.
  ///
  ///The text style is set to use the Poppins font with a font size of 18.
  ///
  ///If the [_headingDescText] parameter is null, an empty string is displayed.
  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        _headingDescText ?? '',
        style: const TextStyle(fontSize: 18, fontFamily: "Poppins"),
      ),
    );
  }
}
