import 'package:flutter/material.dart';


class CustomMessagePopUpMenu extends StatelessWidget {

  final List<PopupMenuItem> _popUpMenuItem = [
    PopupMenuItem(
      child: Text('Ad detail'),
      value: 0,
    ),
    PopupMenuItem(
      child: Text('Profile detail'),
      value: 1,
    ),
  ];

  void _selected(dynamic n){
   print(n);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      offset: Offset(100,100),
      onSelected: (n) {
        _selected(n);
      },
      itemBuilder: (context) {
        return _popUpMenuItem;
      },
    );
  }
}
