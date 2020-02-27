import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {

  final FirebaseUser cUser;

  HomeTab({@required this.cUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: PageStorageKey('home'),
      child: Text(this.cUser.phoneNumber.toString()),
    );
  }
}
