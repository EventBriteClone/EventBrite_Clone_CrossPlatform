import 'package:flutter/material.dart';
import 'package:organizer/components/single_date.dart';
import 'package:organizer/providers/common_providers/dropd_down_state_provider.dart';
import 'package:organizer/providers/creator/basic_info_provider.dart';
import 'package:organizer/providers/creator/date_selection_provider.dart';
import 'package:organizer/providers/creator/details_provider.dart';
import 'package:organizer/providers/creator/icon_state_provider.dart';
import 'package:organizer/providers/creator/side_menu_icon_state_provider.dart';
import 'package:organizer/screens/creator/basic_info/basic_info.dart';
import 'package:organizer/screens/creator/create_event/add_event_p_one.dart';
import 'package:organizer/screens/creator/create_event/add_event_p_two.dart';
import 'package:organizer/screens/creator/events_page/events.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const EventBriteapp());
}

class EventBriteapp extends StatelessWidget {
  const EventBriteapp({super.key});

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
      child: const MaterialApp(
        home: EventPage(),
        //home: AddDetails(),
        //home: BasicInfo(),
        //home: AddEvents(),
        //debugShowCheckedModeBanner: false,
      ),
    );
  }
}
