import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/custom_pluging/custom_button.dart';
import 'package:room_finder/functions/constants.dart';

class SearchTab extends StatelessWidget {
  final FirebaseUser cUser;

  SearchTab({@required this.cUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: PageStorageKey('search'),
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
                  'Search to rooms and roommates!',
                  style: Theme.of(context).textTheme.subtitle,
                ),
                SizedBox(
                  height: kDefaultPadding / 4,
                ),
                Text(
                  'SpareRoom helps you to post ads for room partners and  rooms.',
                  style: Theme.of(context).textTheme.caption,
                ),
                CustomButton(
                  padded: false,
                  bgColor: Theme.of(context).accentColor,
                  title: Text('Search rooms'),
                  pressed: (){

                  },
                ),
                CustomButton(
                  padded: false,
                  title: Text('Search flatmates'),
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
