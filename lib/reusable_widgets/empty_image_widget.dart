import 'package:flutter/material.dart';

///This widget is just for displaying an empty image throigh a [Container]
class EmptyImage extends StatelessWidget {
  const EmptyImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.height * 1,
        color: Color.fromARGB(234, 75, 77, 98),
        child: Transform.scale(
          scale: 2.0,
          child: Icon(
            Icons.camera_alt,
            color: Color.fromARGB(255, 30, 10, 61),
          ),
        ),
      ),
    );
  }
}
