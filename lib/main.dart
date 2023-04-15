// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';

import 'package:event_brite_app/providers/common_providers/dropd_down_state_provider.dart';
import 'package:event_brite_app/providers/creator/basic_info_provider.dart';
import 'package:event_brite_app/providers/creator/date_selection_provider.dart';
import 'package:event_brite_app/providers/creator/details_provider.dart';
import 'package:event_brite_app/providers/creator/icon_state_provider.dart';
import 'package:event_brite_app/providers/creator/side_menu_icon_state_provider.dart';
import 'package:event_brite_app/screens/home_page/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BasicInfoFormDataProvider()),
        ChangeNotifierProvider(create: (_) => DetailsFormDataProvider()),
        ChangeNotifierProvider(create: (_) => DropdownState()),
        ChangeNotifierProvider(create: (_) => IconState()),
        ChangeNotifierProvider(create: (_) => DateSelectionModel()),
        ChangeNotifierProvider(create: (_) => SideMenuItemState()),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Neue Plak'),
        home: HomeScreen(selectedIndex: 0),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


