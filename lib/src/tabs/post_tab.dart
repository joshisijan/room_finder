import 'package:flutter/material.dart';
import 'package:room_finder/src/reuseables/custom_button.dart';
import 'package:room_finder/src/values/constants.dart';


class PostTab extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Hello User,',
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(
                  height: kDefaultPadding / 2,
                ),
                Text(
                  'Post ads for rooms and roommates!',
                  style: Theme.of(context).textTheme.subtitle2,
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
