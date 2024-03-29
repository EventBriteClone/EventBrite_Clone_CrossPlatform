

import '../constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreatorCustomButton extends StatelessWidget {
  CreatorCustomButton({super.key, this.onTap, required this.child});
  final VoidCallback? onTap;
  // final authTokenProvider = Provider.of<AuthTokenProvider>(context);
  //final String text;
  final Widget child;
  @override
  // TODO: implement key
  Key? get key => super.key;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: key,
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[350]!,
              offset: Offset(5.0, 5.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-5.0, -5.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
               Color.fromRGBO(60, 0, 105, 1),
               Color.fromRGBO(60, 0, 100, 1),
            ],
          ),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(15),
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(15),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
