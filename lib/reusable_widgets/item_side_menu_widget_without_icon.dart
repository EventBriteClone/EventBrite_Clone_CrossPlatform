

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/creator/icon_state_provider.dart';
import '../providers/creator/side_menu_icon_state_provider.dart';


///This represnts the UI of [ItemSideMenuWidget] which is a custom widget for displaying each item in the side menu without icons unlike the other
///It conatins:
///           [itemTitle] which is a [String] that represents the text of the item in the side menu
///           [page] which is a [Widget] that represents the page it would be routed to when the item is pressed

class ItemSideMenuWidget extends StatelessWidget {
  final String itemTitle;
  final Widget page;

  const ItemSideMenuWidget({
    Key? key,
    required this.itemTitle,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SideMenuItemState>(
      builder: (context, itemState, child) {
        bool isSelected = itemState.selectedItem == itemTitle;
        return Container(
          decoration: BoxDecoration(
            color:
                isSelected ? Colors.white : Color.fromARGB(100, 255, 255, 255),
            border: Border.all(
              color: isSelected
                  ? Colors.white
                  : Color.fromARGB(100, 255, 255, 255),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 0),
            child: ListTile(
              title: Text(
                itemTitle,
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: "segoe ui",
                  color: Color.fromARGB(221, 30, 30, 30),
                ),
              ),
              onTap: () {
                itemState.setSelectedItem(itemTitle);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
