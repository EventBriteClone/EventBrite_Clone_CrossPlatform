import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GmailPage extends StatelessWidget {
  const GmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gmail Page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Open Gmail'),
          onPressed: () {
            launchUrlString('mailto:');
          },
        ),
      ),
    );
  }
}
