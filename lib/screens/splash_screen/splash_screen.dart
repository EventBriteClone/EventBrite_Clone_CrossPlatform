// ignore_for_file: use_key_in_widget_constructors
import 'package:event_brite_app/screens/home_page/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            builder: (context) => const HomeScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Center(
        child: SvgPicture.asset(
          'assets/images/EventusLogoSVG.svg',
          width: MediaQuery.of(context).size.width * 0.12,
          height: MediaQuery.of(context).size.width * 0.12,
          colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn,),
        ),
        // child: Image(
        //   image: const AssetImage('assets/images/EventusLogoSVG.svg'),
        //   color: primaryColor,
        //   width: MediaQuery.of(context).size.width*0.4,
        //   height: MediaQuery.of(context).size.width * 0.4,
        // ),
      ),
    );
  }
}
