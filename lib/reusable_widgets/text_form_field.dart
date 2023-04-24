import 'package:flutter/material.dart';

/// A custom [TextFormField] widget that can be used to input text with validation.

class TextFormFieldWidget extends StatelessWidget {
  /// Creates a new instance of [TextFormFieldWidget].
  ///
  /// * [eventTitleController] - A [TextEditingController] to control the text field.
  /// * [label] - A [String] to show as the label for the text field.
  /// * [hint] - A [String] to show as the hint for the text field.
  /// * [isRequired] - A [bool] that determines whether or not the text field is required.
  /// * [onChanged] - An optional callback function that might be needed in some textfields to display something in the same page
  /// * [maxlines]  - an optional maxlines of type [int]
  /// * [maxLength] - an optional maxlength of type [int]
  /// * [initialValue] - a required paramter that saves initial value of form data in case when prefilling the form is required
  const TextFormFieldWidget({
    Key? key,
    required TextEditingController eventTitleController,
    required String? label,
    required String? hint,
    required bool? isRequired,
     String? initialValue,
    int? maxLength,
    int? maxlines,
    this.onChanged,
  })  : _eventTitleController = eventTitleController,
        _label = label,
        _hint = hint,
        _isRequired = isRequired,
        _maxLength = maxLength,
        _maxlines = maxlines,
        _initialValue = initialValue,
        super(key: key);

  final TextEditingController _eventTitleController;
  final String? _label;
  final String? _hint;
  final bool? _isRequired;
  final void Function(String)? onChanged;
  final int? _maxLength;
  final int? _maxlines;
  final String? _initialValue;

  @override
  Widget build(BuildContext context) {
    /// Returns a [TextFormField] widget wrapped in [Padding] widget with a set of attributes such as [maxLength], [decoration], [validator].
    ///
    /// [_isRequired] boolean is used to show error message if the field is empty and required.
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: _eventTitleController,
       // controller: ,
        maxLength: _maxLength ?? 75, //we also have maxLines
        initialValue: _initialValue,
        decoration: InputDecoration(
          // hintText: 'Be clear and descriptive.',
          hintText: _hint,
          hintStyle: const TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 184, 180, 180),
              fontFamily: "Poppins",
              fontWeight: FontWeight.w700),

          labelText: _label,

          labelStyle: const TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 100, 117, 224),
          ),
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 100, 117, 224),
              width: 2.0,
            ),
          ),
          suffixIcon: _isRequired!
              ? const Text(
                  '*',
                  style: TextStyle(color: Colors.red, fontSize: 24),
                )
              : null,
        ),
        onChanged: onChanged,
        validator: (value) {
          if (_isRequired == true) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          }
        },
      ),
    );
  }
}

