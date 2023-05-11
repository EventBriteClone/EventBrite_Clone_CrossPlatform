import 'package:event_brite_app/models/basic_info_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../functions/utils/back_button_to_events.dart';
import '../providers/creator/basic_info_provider.dart';
import '../providers/creator/icon_state_provider.dart';
import '../reusable_widgets/item_side_menu_widget_with_icon.dart';
import '../reusable_widgets/item_side_menu_widget_without_icon.dart';
import '../screens/creator/basic_info/basic_info.dart';
import '../screens/creator/basic_info/dashboard.dart';
import '../screens/creator/basic_info/manage_attendees.dart';
import '../screens/creator/basic_info/publish.dart';
import '../screens/creator/basic_info/tickets/add_ticket.dart';

///This is a method called [buildDrawer] to build the drawer for the side menu that exists inside [BasicInfo] page
///it returns a [Drawer] which is a flutter built in drawer widget with a [ListView] for all our components
///It helps navigate between these pages=> [BasicInfo], [Publish], [Tickets], [Dashboard], [ManageAttendees]
///We use  [IconSideMenuWidget] to represent each item in the sidemenu and also uses [ItemSideMenuWidget]
///The difference is that [ItemSideMenuWidget] doesnt have an icon beside it

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: const Color.fromARGB(222, 255, 255, 255),
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        backButtonToEvents(context),
        const Divider(
          color: Color.fromARGB(245, 220, 220, 220),
          thickness: 2,
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 70.0, left: 20),
          child: Consumer<BasicInfoFormDataProvider>(
              builder: (BuildContext context, data, Widget? child) {
            final formData = data.formData;
            print('inside side menu');
            print(formData.eventID);

            //final singleorRecurring = formData.singleOrRecurring;

            String formattedDateStart = '';

            String formattedStartTime = '';

            final eventStart = formData.eventStart!;
            final startTime = formData.startTime!;

            formattedDateStart = eventStart.toString().substring(0, 10);
            formattedDateStart = DateFormat('E, d MMM yyyy').format(eventStart);
            formattedStartTime = DateFormat.jm()
                .format(DateTime(1, 1, 1, startTime.hour, startTime.minute));

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  //'Event Title',
                  formData.eventTitle!,
                  style: const TextStyle(
                      fontSize: 30,
                      fontFamily: "Poppins",
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '$formattedDateStart   $formattedStartTime',
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: "Poppins",
                    color: Colors.black,
                  ),
                )
              ],
            );
          }),
        ),
        const SizedBox(
          height: 30,
        ),
        const Divider(
          color: Color.fromARGB(245, 220, 220, 220),
          thickness: 2,
          height: 20,
        ),
        const IconSideMenuWidget(
          itemNumber: '1',
          page: BasicInfo(),
          itemTitle: 'Basic Info',
        ),
        const IconSideMenuWidget(
          itemNumber: '2',
          page: Tickets(),
          itemTitle: 'Tickets',
        ),
        IconSideMenuWidget(
          itemNumber: '3',
          page: DependentDropdownMenu(),
          itemTitle: 'Publish',
        ),
        const Divider(
          color: Color.fromARGB(245, 220, 220, 220),
          thickness: 2,
          height: 20,
        ),
        const SizedBox(height: 20),
        const ItemSideMenuWidget(
            itemTitle: 'Dashboard', page: DashboardScreen()),
        const SizedBox(height: 40),
        ItemSideMenuWidget(itemTitle: 'Manage Attendees', page: FirstPage()),
      ],
    ),
  );
}
