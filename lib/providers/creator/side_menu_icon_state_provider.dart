import 'package:flutter/material.dart';

/// It will notify all listerners that data has changed using  [notifyListeners]
class SideMenuItemState extends ChangeNotifier {
  String _selectedItem = "";

  String get selectedItem => _selectedItem;

  void setSelectedItem(String item) {
    _selectedItem = item;
    notifyListeners();
  }
}
