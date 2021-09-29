import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:room_finder/src/values/constants.dart';
import 'package:room_finder/src/screens/ad_detail.dart';

class OwnAdCard extends StatefulWidget {
  final String id;
  final List<Widget> images;
  final String adUserId;
  final String currentUserId;
  final int rent;
  final int deposit;
  final String postId;
  final int type;
  final String terms;
  final LatLng latLng;

  OwnAdCard({
    @required this.id,
    @required this.images,
    @required this.adUserId,
    @required this.currentUserId,
    @required this.rent,
    @required this.deposit,
    @required this.postId,
    @required this.terms,
    @required this.type,
    @required this.latLng,
  });

  @override
  _OwnAdCardState createState() => _OwnAdCardState();
}

class _OwnAdCardState extends State<OwnAdCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AdDetail(
              isOwn: true,
              adDetail: {
                'type': widget.type,
                'rent': widget.rent,
                'deposit': widget.deposit,
                'images': widget.images,
                'adUserId': widget.adUserId,
                'currentUserId': widget.currentUserId,
                'postId': widget.postId,
                'terms': widget.terms,
                'latLng': widget.latLng,
              },
            );
          }));
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kDefaultPadding),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .fontSize,
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
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .fontSize,
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
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .fontSize,
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
              MaterialButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    Text(
                      'Remove Ad',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                color: Theme.of(context).errorColor,
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('ads')
                      .doc(widget.id)
                      .delete();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
