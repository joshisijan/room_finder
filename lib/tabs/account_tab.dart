import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/pages/edit_profile.dart';
import 'package:room_finder/pages/my_ads.dart';
import 'package:room_finder/pages/photo_view.dart';
import 'package:room_finder/pages/watchlist.dart';

class AccountTab extends StatelessWidget {
  final FirebaseAuth _fbAuth = FirebaseAuth.instance;

  final FirebaseUser cUser;

  final Firestore _fireStore = Firestore.instance;

  AccountTab({@required this.cUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: PageStorageKey('account'),
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: GestureDetector(
              onTap: () {
                if (this.cUser.photoUrl != null) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return NetworkPhotoViewPage(url: this.cUser.photoUrl);
                    },
                  ));
                }
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(this.cUser.photoUrl ?? ''),
              ),
            ),
            otherAccountsPictures: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return EditProfile(cUser: this.cUser);
                    },
                  ));
                },
              ),
            ],
            accountEmail: Text('Number: ' + this.cUser.phoneNumber.toString()),
            accountName: Text('Name: ' + (this.cUser.displayName ?? ' ')),
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Text('My Ads '),
                StreamBuilder(
                  stream: _fireStore
                      .collection('posts')
                      .where('userid', isEqualTo: this.cUser.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text('(--)');
                    } else {
                      var _userData = snapshot.data.documents;
                      if (_userData.isEmpty) {
                        return Text('(0)');
                      } else {
                        return Text('(${_userData.length.toString()})');
                      }
                    }
                  },
                ),
              ],
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyAds(
                  cUser: this.cUser,
                );
              }));
            },
            trailing: Icon(Icons.apps),
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Text('My Watchlist '),
                StreamBuilder(
                  stream: _fireStore
                      .collection('watchlist')
                      .where('userId', isEqualTo: this.cUser.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text('(--)');
                    } else {
                      var _userData = snapshot.data.documents;
                      if (_userData.isEmpty) {
                        return Text('(0)');
                      } else {
                        return Text('(${_userData.length.toString()})');
                      }
                    }
                  },
                ),
              ],
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return WatchList(
                  cUser: this.cUser,
                );
              }));
            },
            trailing: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
          ListTile(
            title: Text('App Settings'),
            onTap: () {
              Navigator.pushNamed(context, '/setting');
            },
            trailing: Icon(Icons.settings),
          ),
          ListTile(
            title: Text('log out'),
            onTap: () {
              _fbAuth.signOut();
            },
            trailing: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
