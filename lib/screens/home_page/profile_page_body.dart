// ignore_for_file: use_key_in_widget_constructors

import 'package:event_brite_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../reusable_widgets/custom_column.dart';
import '../../reusable_widgets/log_out_button.dart';
import '../../reusable_widgets/profile_custom_container.dart';

class ProfilePageBody extends StatelessWidget {
  const ProfilePageBody({key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                const CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 45,
                  backgroundImage: AssetImage(
                    'assets/images/Eventbrite_logo.png',
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Center(
                  child: Text(
                    'Kareem Hassan',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                const Center(
                  child: Opacity(
                    opacity: 0.8,
                    child: Text(
                      'kareemsobhi50@gmail.com',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    CustomColumn(
                      text: 'Likes',
                    ),
                    VerticalDivider(
                      width: 10,
                      thickness: 1,
                      color: Colors.black,
                      indent: 5,
                      endIndent: 50,
                    ),
                    CustomColumn(
                      text: 'My tickets',
                    ),
                    VerticalDivider(
                      width: 10,
                      thickness: 1,
                      color: Colors.black,
                      indent: 5,
                      endIndent: 50,
                    ),
                    CustomColumn(
                      text: 'Following',
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const ProfileSettingsContainer(
                  sizedBoxWidth: 15,
                  text: "Notification Centre",
                  icon: FontAwesomeIcons.bell,
                ),
                const Divider(
                  thickness: 1,
                ),
                const ProfileSettingsContainer(
                  text: "Linked Accounts",
                  sizedBoxWidth: null,
                  icon: null,
                ),
                const Divider(
                  thickness: 1,
                ),
                const ProfileSettingsContainer(
                  text: "Following",
                  sizedBoxWidth: null,
                  icon: null,
                ),
                const Divider(
                  thickness: 1,
                ),
                const ProfileSettingsContainer(
                  text: "Ticket Issues",
                  sizedBoxWidth: null,
                  icon: null,
                ),
                const Divider(
                  thickness: 1,
                ),
                const ProfileSettingsContainer(
                  text: "Manage Events",
                  sizedBoxWidth: null,
                  icon: null,
                ),
                const Divider(
                  thickness: 1,
                ),
                const ProfileSettingsContainer(
                  text: "Settings",
                  sizedBoxWidth: null,
                  icon: null,
                ),
              ],
            ),
          ),
          const LogOutButton(
            containerColor: primaryColor,
            text: 'Log out',
            icon: null,
            sizedBoxWidth: null,
          ),
        ],
      ),
    );
  }
}
