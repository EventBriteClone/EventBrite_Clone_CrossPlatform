import 'dart:math';
import 'package:event_brite_app/constants.dart';
import 'package:event_brite_app/screens/home_page/search_screen_body.dart';

import '../login_signin_pages/log_in_page1.dart';
import '../login_signin_pages/log_in_page2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import '/../lib/constants.dart';
import 'home_screen_body.dart';
import 'profile_page_body.dart';
//import 'search_screen_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const List<Widget> pages = <Widget>[
    HomeScreenBody(),
    SearchScreen(),
    LogInPage1() ,
    //LogInPage2(),
    HomeScreenBody(),
    ProfilePageBody(),
    
  ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  // function to change body with bottom navigation bar
  void _onItemTapped(int index) {
    setState(
      () {
        selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: HomeScreen.pages.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.home_outlined,
              color: selectedIndex == 0 ? Colors.red : Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.search,
              color: selectedIndex == 1 ? Colors.red : Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              FontAwesomeIcons.heart,
              color: selectedIndex == 2 ?  Colors.red : Colors.black,
              size: 18,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Transform.rotate(
              angle: pi / 2,
              child: Icon(
                Icons.confirmation_number_outlined,
                size: 23,
                color: selectedIndex == 3 ? Colors.red : Colors.black,
              ),
            ),
          ),
          
          
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              FontAwesomeIcons.user,
              size: 19,
              color: selectedIndex == 4 ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
      
    );
  }
}
