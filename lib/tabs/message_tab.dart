import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class MessageTab extends StatelessWidget {
  final FirebaseUser cUser;

  MessageTab({@required this.cUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: PageStorageKey('message'),
      child: Text(this.cUser.toString()),
    );
  }
}
