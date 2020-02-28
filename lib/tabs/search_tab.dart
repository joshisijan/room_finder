import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchTab extends StatelessWidget {
  final FirebaseUser cUser;

  SearchTab({@required this.cUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: PageStorageKey('search'),
      child: Text(this.cUser.photoUrl.toString()),
    );
  }
}
