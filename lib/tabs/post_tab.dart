import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/custom_pluging/custom_button.dart';
import 'package:room_finder/functions/constants.dart';


class PostTab extends StatelessWidget {
  final FirebaseUser cUser;

  PostTab({@required this.cUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: PageStorageKey('post'),
      child: ListView(
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
                  'Post ads for rooms and roommates!',
                  style: Theme.of(context).textTheme.subtitle,
                ),
                SizedBox(
                  height: kDefaultPadding / 4,
                ),
                Text(
                  'SpareRoom helps you to get a prefect room partner or just a perfect room.',
                  style: Theme.of(context).textTheme.caption,
                ),
                CustomButton(
                  padded: false,
                  bgColor: Theme.of(context).accentColor,
                  title: Text('Post ads for rooms'),
                  pressed: (){

                  },
                ),
                CustomButton(
                  padded: false,
                  title: Text('Post ads for flatmates'),
                  pressed: (){

                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
