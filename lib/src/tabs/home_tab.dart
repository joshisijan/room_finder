import 'package:flutter/material.dart';
import 'package:room_finder/src/reuseables/ad_card.dart';
import 'package:room_finder/src/values/constants.dart';

class HomeTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Hello User',
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(
                  height: kDefaultPadding / 2,
                ),
                Text(
                  'ROOMS AND ROOMMATES!',
                  style: Theme.of(context).textTheme.subtitle1,
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
          AdCard(
            images: [
              Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png'),
            ],
            adUserId: 'user id',
            currentUserId: 'current user id',
            location: 'location',
            rent: 200,
            deposit: 100,
            postId: 'postId',
            type: 0,
          ),
        ],
      ),
    );
  }
}
