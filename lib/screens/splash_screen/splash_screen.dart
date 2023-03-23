// ignore_for_file: use_key_in_widget_constructors

import 'package:event_brite_app/screens/choose_your_fav_categories/choose_your_fav_categories.dart';
import 'package:event_brite_app/screens/find_events/find_events.dart';
import 'package:event_brite_app/screens/home_page/home_screen.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  void navigateToHome() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: secondaryColor,
      body: Center(
        child: Image(
          image: AssetImage('assets/images/Eventbrite_logo.png'),
          color: primaryColor,
          width: 275,
          height: 275,
        ),
      ),
    );
  }
}
