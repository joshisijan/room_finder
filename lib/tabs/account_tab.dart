import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/pages/edit_profile.dart';

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
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(this.cUser.photoUrl ??
                  'https://picsum.photos/seed/picsum/200/300'),
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
                Text('Name: ' + (this.cUser.displayName ?? 'not set yet')),
          ),
          ListTile(
            title: Text('Posted Ads'),
            onTap: () {
              Navigator.pushNamed(context, '/setting');
            },
            trailing: Icon(Icons.apps),
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
