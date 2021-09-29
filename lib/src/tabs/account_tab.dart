import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/src/providers/home_loading_provider.dart';
import 'package:room_finder/src/screens/edit_profile.dart';
import 'package:room_finder/src/screens/my_ads.dart';
import 'package:room_finder/src/screens/photo_view.dart';
import 'package:room_finder/src/screens/signin.dart';
import 'package:provider/provider.dart';
import 'package:room_finder/src/reuseables/circular_cache_image.dart';

class AccountTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;
    return Container(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: GestureDetector(
              onTap: () {
                if (user.photoURL != null) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return NetworkPhotoViewPage(url: user.photoURL);
                    },
                  ));
                }
              },
              child: user.photoURL != null
                  ? CircularCacheImage(
                      photoUrl: user.photoURL,
                      borderColor: Theme.of(context).cardColor.withAlpha(100),
                      diameter: 200.0,
                    )
                  : CircleAvatar(
                      backgroundColor: Theme.of(context).cardColor,
                      child: Icon(
                        Icons.person,
                        size: 36.0,
                      ),
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
            accountEmail: Text('Email: ${user.email}'),
            accountName: user.displayName == ''
                ? Text('unnamed')
                : Text('Name: ${user.displayName}'),
          ),
          ListTile(
            title: Text('My Ads'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyAds();
              }));
            },
            trailing: Icon(Icons.apps),
          ),
          ListTile(
            title: Text('log out'),
            onTap: () async {
              context.read<HomeLoadingProvider>().setLoading(true);
              await FirebaseAuth.instance.signOut();
              context.read<HomeLoadingProvider>().setLoading(false);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignInPage()));
            },
            trailing: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
