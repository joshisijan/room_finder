import 'package:flutter/material.dart';


class MessageTab extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      key: PageStorageKey('message'),
      child: Container(
        child: Text('message'),
      ),
    );
  }
}

