import 'package:flutter/material.dart';

class LogOutButton extends StatelessWidget {
  LogOutButton({
    super.key,
    this.onTap,
    this.onPressed,
    this.containerColor,
    required this.text,
    @required this.icon,
    @required this.sizedBoxWidth,
    @required this.size = 0,
  });
  VoidCallback? onTap;
  final Color? containerColor;
  final String? text;
  final IconData? icon;
  final double? sizedBoxWidth;
  final double? size;
  //bool _isButtonEnabled ;
  //final Image? image;
  //bool imgFlag;
  //VoidCallback? onTap;
  VoidCallback? onPressed;
  @override
  Key? get key => super.key;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: key,
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          color: containerColor,
          border: Border.all(
            color: const Color.fromARGB(255, 120, 118, 118),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //image,
            Icon(
              icon,
              color: const Color.fromARGB(255, 42, 81, 239),
              size: size,
            ),
            SizedBox(
              width: sizedBoxWidth,
            ),
            Center(
              child: Text(
                text!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
