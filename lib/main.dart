// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'screens/splash_screen/splash_screen.dart';
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main()async {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}
///youssef is here
class MyApp extends StatelessWidget {
  const MyApp({key});

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


