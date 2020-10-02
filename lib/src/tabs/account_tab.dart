import 'package:flutter/material.dart';
import 'package:room_finder/src/screens/edit_profile.dart';
import 'package:room_finder/src/screens/my_ads.dart';
import 'package:room_finder/src/screens/photo_view.dart';
import 'package:room_finder/src/screens/watchlist.dart';

class AccountTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      key: PageStorageKey('account'),
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return NetworkPhotoViewPage(url: '');
                  },
                ));
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(''),
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
                      return EditProfile();
                    },
                  ));
                },
              ),
            ],
            accountEmail: Text('Number: 34324'),
            accountName: Text('Name: sijan joshi'),
          ),
          ListTile(
            title: Text('title'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyAds();
              }));
            },
            trailing: Icon(Icons.apps),
          ),
          ListTile(
            title: Text('titel'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return WatchList();
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
              print('log out');
            },
            trailing: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
