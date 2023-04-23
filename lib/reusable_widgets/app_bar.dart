import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer(); // Add this line to open the drawer
        },
      ),
      title: Text(
        'Events',
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      ), //our title
      backgroundColor: Color.fromARGB(255, 30, 10, 61),
      actions: [
        IconButton(
          onPressed: () {}, //navigate to search page
          icon: Icon(Icons.search),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
