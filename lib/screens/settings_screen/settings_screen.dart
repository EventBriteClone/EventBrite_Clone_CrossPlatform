import 'package:event_brite_app/constants.dart';
import 'package:flutter/material.dart';
import 'custom_settings_container.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.w900,
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () async {
            // Navigator.pop(context);
            // List<Placemark> position =
            //     await determineLocation(); /// temp variable for geolocator service
            // print(position.elementAt(2).administrativeArea);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            SizedBox(
              height: 15,
            ),
            Text(
              'Account',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomSettingsContainer(
              text: 'Push Notifications',
            ),
            CustomSettingsContainer(
              text: 'Facebook',
            ),
            Text(
              'About',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomSettingsContainer(
              text: 'Rate Us',
            ),
            CustomSettingsContainer(
              text: 'Suggest Improvement',
            ),
            CustomSettingsContainer(
              text: 'Legal',
            ),
            CustomSettingsContainer(
              text: 'How to use the app',
            ),
            CustomSettingsContainer(
              text: 'Acknowledgements',
            ),
            Text(
              'Profile',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomSettingsContainer(
              text: 'kareemsobhi50@gmail.com',
            ),
            CustomSettingsContainer(
              text: 'Eventbrite\nVersion 9.24.0 (81040)',
            ),
          ],
        ),
      ),
    );
  }
}
