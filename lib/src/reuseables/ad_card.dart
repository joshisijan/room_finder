import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/src/values/constants.dart';
import 'package:room_finder/src/screens/ad_detail.dart';
import 'package:room_finder/src/reuseables/circular_cache_image.dart';

class AdCard extends StatefulWidget {
  final List<Widget> images;
  final String adUserId;
  final String currentUserId;
  final int rent;
  final int deposit;
  final String postId;
  final int type;
  final String terms;

  AdCard(
      {@required this.images,
      @required this.adUserId,
      @required this.currentUserId,
      @required this.rent,
      @required this.deposit,
      @required this.postId,
      @required this.terms,
      @required this.type});

  @override
  _AdCardState createState() => _AdCardState();
}

class _AdCardState extends State<AdCard> {
  String userName = 'Loading...';

  String profilePhotoUrl = '';

  @override
  void initState() {
    super.initState();
    () async {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      firebaseFirestore
          .collection('users')
          .doc(widget.adUserId)
          .get()
          .then((value) {
        var data = value.data();
        if (data != null) {
          setState(() {
            userName = data['displayName'];
            profilePhotoUrl = data['photoURL'];
          });
        }
      });
    }.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return AdDetail(
            adDetail: {
              'type': widget.type,
              'rent': widget.rent,
              'deposit': widget.deposit,
              'images': widget.images,
              'adUserId': widget.adUserId,
              'currentUserId': widget.currentUserId,
              'postId': widget.postId,
              'terms': widget.terms,
            },
          );
        }));
      },
      child: Container(
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
                  child: profilePhotoUrl != ''
                      ? CircularCacheImage(
                          photoUrl: profilePhotoUrl,
                          borderColor: Theme.of(context)
                              .textTheme
                              .caption
                              .color
                              .withAlpha(100),
                        )
                      : SizedBox.shrink(),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: kDefaultPadding / 2,
                    ),
                    Text(
                      userName,
                      style: Theme.of(context).textTheme.bodyText1,
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
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                enableInfiniteScroll: false,
                height: 200,
              ),
              items: widget.images,
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
                      'Rs.' + widget.rent.toString() + '/M',
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
                      'Rs.' + widget.deposit.toString(),
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
                      widget.type == 0
                          ? 'Rent'
                          : widget.type == 1
                              ? 'Roommate'
                              : 'Paying Guest',
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
      ),
    );
  }
}
