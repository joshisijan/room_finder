import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/pages/edit_profile.dart';
import 'package:room_finder/pages/photo_view.dart';

class AccountTab extends StatelessWidget {
  final FirebaseAuth _fbAuth = FirebaseAuth.instance;

  final FirebaseUser cUser;

  AccountTab({@required this.cUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: PageStorageKey('account'),
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: GestureDetector(
              onTap: (){
                if(this.cUser.photoUrl != null){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context){
                      return NetworkPhotoViewPage(url: this.cUser.photoUrl);
                    },
                  ));
                }
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(this.cUser.photoUrl ??
                    ''),
              ),
            ),
            otherAccountsPictures: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context){
                      return EditProfile(cUser: this.cUser);
                    },
                  ));
                },
              ),
            ],
            accountEmail: Text('Number: ' + this.cUser.phoneNumber.toString()),
            accountName:
                Text('Name: ' + (this.cUser.displayName ?? ' ')),
          ),
          ListTile(
            title: Text('Posted Ads (10)'),
            onTap: () {
              Navigator.pushNamed(context, '/setting');
            },
            trailing: Icon(Icons.apps),
          ),
          ListTile(
            title: Text('My Watchlist (2)'),
            onTap: () {
              Navigator.pushNamed(context, '/setting');
            },
            trailing: Icon(Icons.favorite),
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
