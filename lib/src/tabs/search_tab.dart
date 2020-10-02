import 'package:flutter/material.dart';
import 'package:room_finder/src/reuseables/custom_button.dart';
import 'package:room_finder/src/values/constants.dart';

class SearchTab extends StatelessWidget {

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
                  'Hello Usser,',
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(
                  height: kDefaultPadding / 2,
                ),
                Text(
                  'Search to rooms and roommates!',
                  style: Theme.of(context).textTheme.subtitle2,
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
