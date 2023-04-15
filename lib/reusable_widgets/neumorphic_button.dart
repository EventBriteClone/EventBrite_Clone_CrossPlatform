import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NNeumorphicButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color backgroundColor;

  const NNeumorphicButton({
    //Key key,
    required this.onPressed,
    required this.child,
    required this.backgroundColor,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        color: backgroundColor,
        shape: NeumorphicShape.flat,
        depth: 8,
        intensity: 0.8,
        lightSource: LightSource.topLeft,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          elevation: MaterialStateProperty.all(0),
        ),
        child: child,
      ),
    );
  }
}
