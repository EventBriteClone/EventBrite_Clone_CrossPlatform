// ignore_for_file: use_key_in_widget_constructors

import 'dart:math';
import 'package:event_brite_app/screens/login_signin_pages/log_in_page1.dart';
import 'package:event_brite_app/screens/search_screen.dart/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../constants.dart';
import 'home_screen_body.dart';
import 'profile_page_body.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({key, required this.selectedIndex});
int selectedIndex;
  static const List<Widget> pages = <Widget>[
    HomeScreenBody(),
    SearchScreen(),
    LogInPage1(),
    HomeScreenBody(),
    ProfilePageBody(),
  ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  // function to change body with bottom navigation bar
  void _onItemTapped(int index) {
    setState(
      () {
        widget.selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: HomeScreen.pages.elementAt(widget.selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.home_outlined,
              color: widget.selectedIndex == 0 ? Colors.red : Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.search,
              color: widget.selectedIndex == 1 ? Colors.red : Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              FontAwesomeIcons.heart,
              color: widget.selectedIndex == 2 ? Colors.red : Colors.black,
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
                color: widget.selectedIndex == 3 ? Colors.red : Colors.black,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              FontAwesomeIcons.user,
              size: 19,
              color: widget.selectedIndex == 4 ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
