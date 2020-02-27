import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class PostTab extends StatelessWidget {
  final FirebaseUser cUser;

  PostTab({@required this.cUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: PageStorageKey('post'),
      child: Text(this.cUser.toString()),
    );
  }
}
