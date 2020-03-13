import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/custom_pluging/ad_card.dart';
import 'package:room_finder/functions/constants.dart';

class HomeTab extends StatelessWidget {
  final FirebaseUser cUser;

  final Firestore _cloudFirestore = Firestore.instance;

  HomeTab({@required this.cUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: PageStorageKey('home'),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Hello ' + (this.cUser.displayName ?? 'unnamed') + ',',
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(
                  height: kDefaultPadding / 2,
                ),
                Text(
                  'ROOMS AND ROOMMATES!',
                  style: Theme.of(context).textTheme.subtitle,
                ),
                SizedBox(
                  height: kDefaultPadding / 4,
                ),
                Text(
                  'Here are some rooms and roommates for you.',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _cloudFirestore.collection('posts').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(kDefaultPadding),
                      child: Text('Loading...'),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                      child: Padding(
                    padding: EdgeInsets.all(kDefaultPadding),
                    child: Text(
                      snapshot.error.toString(),
                      style: TextStyle(color: Theme.of(context).errorColor),
                    ),
                  ));
                } else {
                  var _userData = snapshot.data.documents;
                  if(_userData.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, n){
                        DocumentSnapshot _ds = snapshot.data.documents[n];
                        int imagesLength = _ds['images'].length;
                        return AdCard(
                          images: List.generate(
                            imagesLength,
                              (n){
                                return Image.network(_ds['images'][n]);
                              }
                          ),
                          adUserId: _ds['userid'],
                          currentUserId: this.cUser.uid,
                          location: _ds['location'],
                          rent: _ds['rent'],
                          deposit: _ds['deposit'],
                          postId: _ds.documentID,
                          type: _ds['type'],
                        );
                      },
                    );
                  }else{
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(kDefaultPadding),
                        child: Text('No posts to show'),
                      ),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
