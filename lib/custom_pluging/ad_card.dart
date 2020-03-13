import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/functions/constants.dart';
import 'package:room_finder/pages/ad_detail.dart';

class AdCard extends StatefulWidget {
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
  _AdCardState createState() => _AdCardState();
}

class _AdCardState extends State<AdCard> {

  Firestore _fireStore = Firestore.instance;

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
                   child: FutureBuilder(
                      future: _fireStore.collection('userDetail').where('userId', isEqualTo: this.widget.adUserId).snapshots().first,
                      builder: (context, snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return CircleAvatar(
                            radius: kDefaultPadding,
                            backgroundColor: Theme.of(context).accentColor,
                          );
                        }else{
                          var _userData = snapshot.data.documents;
                          if(_userData.isNotEmpty){
                            return CircleAvatar(
                              radius: kDefaultPadding,
                              backgroundImage: NetworkImage(_userData[0]['photoUrl']),
                            );
                          }else{
                            return CircleAvatar(
                              radius: kDefaultPadding,
                              backgroundColor: Theme.of(context).accentColor,
                            );
                          }
                        }
                      },
                    )
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
                    child: StreamBuilder(
                      stream: _fireStore.collection('userDetail').where('userId', isEqualTo: this.widget.adUserId).snapshots(),
                      builder: (context, snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Text(
                            'Loading...',
                            style: Theme.of(context).textTheme.subtitle,
                          );
                        }else{
                          var _userData = snapshot.data.documents;
                          if(_userData.isEmpty){
                            return Text(
//                              _userData[0]['displayName'],
                              'unnamed',
                              style: Theme.of(context).textTheme.subtitle,
                            );
                          }else{
                            return Text(
                              _userData[0]['displayName'],
                              style: Theme.of(context).textTheme.subtitle,
                            );
                          }
                        }
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return AdDetail();
                      }));
                    },
                    child: Text(
                      this.widget.location,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                ],
              ),
              actions: <Widget>[
                StreamBuilder(
                  stream: _fireStore.collection('watchlist').where('userId', isEqualTo: this.widget.currentUserId).snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return AbsorbPointer(
                        absorbing: true,
                        child: Opacity(
                          opacity: 0.5,
                          child: IconButton(
                            icon: Icon(
                              Icons.favorite_border,
                              color: Theme.of(context).textTheme.title.color,
                            ),
                            onPressed: () {

                            },
                          ),
                        ),
                      );
                    }else{
                      var _userData = snapshot.data.documents;
                      if(_userData.isNotEmpty){
                        return IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            _removeFromWatchList();
                          },
                        );
                      }else{
                        return IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            color: Theme.of(context).textTheme.title.color,
                          ),
                          onPressed: () {
                            _addToWatchList();
                          },
                        );
                      }
                    }
                  }
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
              height: 200,
              items: this.widget.images,
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
                              Theme.of(context).textTheme.subtitle.fontSize,
                        ),
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  Text(
                    'Rs.' + this.widget.rent.toString() + '/M',
                    style: Theme.of(context).textTheme.subtitle.copyWith(
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
                              Theme.of(context).textTheme.subtitle.fontSize,
                        ),
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  Text(
                    'Rs.' + this.widget.deposit.toString(),
                    style: Theme.of(context).textTheme.subtitle.copyWith(
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
                      Theme.of(context).textTheme.subtitle.fontSize,
                    ),
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  Text(
                    this.widget.type == 0 ? 'Rent' : this.widget.type == 1 ? 'Roommate' : 'Paying Guest',
                    style: Theme.of(context).textTheme.subtitle.copyWith(
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

  void _addToWatchList() async {
    var _watchlist = await _fireStore.collection('watchlist').where('userId',isEqualTo: this.widget.currentUserId).where('postId', isEqualTo: this.widget.postId).getDocuments();
    if(_watchlist.documents.isEmpty){
     await _fireStore.collection('watchlist').add({
       'userId': this.widget.currentUserId,
       'postId': this.widget.postId
     });
    }
  }
  void _removeFromWatchList() async {
    var _watchlist = await _fireStore.collection('watchlist').where('userId',isEqualTo: this.widget.currentUserId).where('postId', isEqualTo: this.widget.postId).getDocuments();
    if(_watchlist.documents.isNotEmpty){
      _watchlist.documents.forEach((doc) async {
        await _fireStore.collection('watchlist').document(doc.documentID).delete();
      });
    }
  }
}
