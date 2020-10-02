import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/src/values/constants.dart';
import 'package:room_finder/src/screens/ad_detail.dart';

class AdCard extends StatelessWidget {
  final List<Widget> images;
  final String adUserId;
  final String currentUserId;
  final String location;
  final int rent;
  final int deposit;
  final String postId;
  final int type;

  AdCard(
      {@required this.images,
        @required this.adUserId,
        @required this.currentUserId,
        @required this.location,
        @required this.rent,
        @required this.deposit,
        @required this.postId,
        @required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              automaticallyImplyLeading: false,
              leading: Padding(
                padding: EdgeInsets.all(kDefaultPadding / 2),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return AdDetail();
                    }));
                  },
                   child: CircleAvatar(
                     radius: kDefaultPadding,
                     backgroundColor: Theme.of(context).accentColor,
                   ),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return AdDetail();
                      }));
                    },
                    child: Text('user name'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return AdDetail();
                      }));
                    },
                    child: Text(
                      location,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                ],
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: Theme.of(context).textTheme.subtitle1.color,
                  ),
                  onPressed: () {

                  },
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return AdDetail();
                },
              ));
            },
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200,
              ),
              items: images,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  Text(
                    'Rent',
                    style: Theme.of(context).textTheme.caption.copyWith(
                          fontSize:
                              Theme.of(context).textTheme.subtitle2.fontSize,
                        ),
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  Text(
                    'Rs.' + rent.toString() + '/M',
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                          fontSize:
                              Theme.of(context).textTheme.caption.fontSize,
                        ),
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  Text(
                    'Deposit',
                    style: Theme.of(context).textTheme.caption.copyWith(
                          fontSize:
                              Theme.of(context).textTheme.subtitle2.fontSize,
                        ),
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  Text(
                    'Rs.' + deposit.toString(),
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                          fontSize:
                              Theme.of(context).textTheme.caption.fontSize,
                        ),
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  Text(
                    'Type',
                    style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize:
                      Theme.of(context).textTheme.subtitle2.fontSize,
                    ),
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  Text(
                    type == 0 ? 'Rent' : type == 1 ? 'Roommate' : 'Paying Guest',
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                      fontSize:
                      Theme.of(context).textTheme.caption.fontSize,
                    ),
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                ],
              ),
              SizedBox(),
            ],
          ),
        ],
      ),
    );
  }

}
