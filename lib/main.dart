import 'package:flutter/material.dart';
import 'screens/splash_screen/splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Neue Plak'),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


