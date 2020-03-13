import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class MessageTab extends StatelessWidget {

  final FirebaseUser cUser;

  MessageTab({@required this.cUser});

  final Firestore _fireStore = Firestore();

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

