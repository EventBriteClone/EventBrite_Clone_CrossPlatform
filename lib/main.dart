// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';

import 'package:event_brite_app/providers/common_providers/dropd_down_state_provider.dart';
import 'package:event_brite_app/providers/creator/basic_info_provider.dart';
import 'package:event_brite_app/providers/creator/date_selection_provider.dart';
import 'package:event_brite_app/providers/creator/date_selection_updated.dart';
import 'package:event_brite_app/providers/creator/details_provider.dart';
import 'package:event_brite_app/providers/creator/icon_state_provider.dart';
import 'package:event_brite_app/providers/creator/promocode_provider.dart';
import 'package:event_brite_app/providers/creator/side_menu_icon_state_provider.dart';
import 'package:event_brite_app/providers/creator/ticket_provider.dart';
import 'package:event_brite_app/providers/creator/updated_event_one_provider.dart';
import 'package:event_brite_app/providers/creator/updated_event_two_provider.dart';
import 'package:event_brite_app/providers/creator/updated_ticket_provider.dart';
import 'package:event_brite_app/providers/token_provider.dart';
import 'package:event_brite_app/screens/creator/basic_info/tickets/add_ticket.dart';
import 'package:event_brite_app/screens/creator/events_page/events.dart';
import 'package:event_brite_app/screens/home_page/home_screen.dart';
import 'package:event_brite_app/screens/login_signin_pages/forget_password.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'package:event_brite_app/screens/login_signin_pages/log_in_page1.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
String? _token;
String? param2Value;
String? param1Value;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  // Initialize the deep link handler
  initUniLinks();

  runApp(MyApp());
}

Future<void> initUniLinks() async {
  // Get the initial deep link URL
  //final initialLink = await getInitialLink();
  //handleDeepLink(initialLink);

  // Listen for deep link changes
  linkStream.listen((link) {
    handleDeepLink(link);
  }, onError: (err) {
    // Handle link stream errors
  });
}

// ignore: non_constant_identifier_names
void LogInPaffdge2ddd(String? param1) {
  print('hj');
  print(param1);
  if (param1 == 'signup') {
    //Navigator.push(context,
    print("kkk");
    //   MaterialPageRoute(builder: (context) {
    //Get.off(EmailValidationScreen());
    //return CchooseCustomerOrOrganiserPage();
    // }));
  }
}

Future handleDeepLink(String? link) async {
  // Parse the deep link URL
  final uri = Uri.parse(link ?? '');
  print('asds');
  print(uri);
  List<String> pathSegments = uri.pathSegments;
  String param1Value = pathSegments[1];
  // 'value1'
  param2Value = pathSegments[2];
  LogInPaffdge2ddd(param1Value);
//return CchooseCustomerOrOrganiserPage();
//LogInPage2ddd(param1Value);
 //if(param2Value=='')  // 'value2'
 print('param');
 print(param2Value);
   
  // Check if the URL matches the deep link pattern
  if (uri.pathSegments.contains('signup')) {
     navigatorKey.currentState?.pushNamed( '/user/signup/null');
    //Navigator.of(c).pushNamed('/user/signup');
    // Retrieve the token from the deep link URL
    //_token = uri.queryParameters['token'];
    print("sad:");
    print(_token);
  }
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
        ChangeNotifierProvider(create: (_) => TicketProviderModel()),
        ChangeNotifierProvider(create: (_) => UpdatedEventOneProvider()),
        ChangeNotifierProvider(create: (_) => UpdatedEventTwoProvider()),
        ChangeNotifierProvider(create: (_) => UpdatedDateSelectionModel()),
        ChangeNotifierProvider(create: (_) => UpdatedTicketProviderModel()),
        ChangeNotifierProvider(create: (_) => PromoCodeProviderModel()),
        ChangeNotifierProvider<TokenModel>(create: (_) => TokenModel()),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Neue Plak'),
        //home: const LogInPage1(),
        navigatorKey: navigatorKey,
        routes: {
          '/': (context) => const LogInPage1(),
          '/user/signup/null': (context) => NewPasswordPage(),
        },
        //home: Tickets(),
        //HomeScreen(selectedIndex: 0),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           child: Text('Sign Up'),
//           onPressed: () {
//             // Navigate to the deep link destination
//             Navigator.pushNamed(context, '/user/signup/');
//           },
//         ),
//       ),
//     );
//   }
// }
@override
void initState() {
  initState();

  // Retrieve and store the token
  final token = _token;
  if (token != null) {
    // TODO: Implement your storage logic here
  }
}

void gotochoose() {}
