import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/custom_pluging/ad_card.dart';

class MyAds extends StatefulWidget {
  final FirebaseUser cUser;

  MyAds({@required this.cUser});

  @override
  _MyAdsState createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> with SingleTickerProviderStateMixin {
  TabController _tabController;

  final Firestore _fireStore = Firestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
      length: 3,
      initialIndex: 0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Ads'),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              text: 'ROOMS',
            ),
            Tab(
              text: 'FLATMATES',
            ),
            Tab(
              text: 'PG',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          StreamBuilder(
            stream: _fireStore
                .collection('posts')
                .where('userid', isEqualTo: this.widget.cUser.uid)
                .where('type', isEqualTo: 0)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text('Loading...'),
                );
              } else {
                var _userData = snapshot.data.documents;
                if (_userData.isNotEmpty) {
                  return ListView.builder(
                    itemCount: _userData.length,
                    itemBuilder: (context, n){
                      DocumentSnapshot _ds = snapshot.data.documents[n];
                      int imagesLength = _ds['images'].length;
                      return AdCard(
                        type: _ds['type'],
                        postId: _ds.documentID,
                        deposit: _ds['deposit'],
                        rent: _ds['rent'],
                        location: _ds['location'],
                        currentUserId: this.widget.cUser.uid,
                        adUserId: _ds['userId'],
                        images: List.generate(
                            imagesLength,
                                (n){
                              return Image.network(_ds['images'][n]);
                            }
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('No ads for roooms'),
                  );
                }
              }
            },
          ),
          StreamBuilder(
            stream: _fireStore
                .collection('posts')
                .where('userid', isEqualTo: this.widget.cUser.uid)
                .where('type', isEqualTo: 1)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text('Loading...'),
                );
              } else {
                var _userData = snapshot.data.documents;
                if (_userData.isNotEmpty) {
                  return ListView.builder(
                    itemCount: _userData.length,
                    itemBuilder: (context, n){
                      DocumentSnapshot _ds = snapshot.data.documents[n];
                      int imagesLength = _ds['images'].length;
                      return AdCard(
                        type: _ds['type'],
                        postId: _ds.documentID,
                        deposit: _ds['deposit'],
                        rent: _ds['rent'],
                        location: _ds['location'],
                        currentUserId: this.widget.cUser.uid,
                        adUserId: _ds['userId'],
                        images: List.generate(
                            imagesLength,
                                (n){
                              return Image.network(_ds['images'][n]);
                            }
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('No ads for roommates'),
                  );
                }
              }
            },
          ),
          StreamBuilder(
            stream: _fireStore
                .collection('posts')
                .where('userid', isEqualTo: this.widget.cUser.uid)
                .where('type', isEqualTo: 2)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text('Loading...'),
                );
              } else {
                var _userData = snapshot.data.documents;
                if (_userData.isNotEmpty) {
                  return ListView.builder(
                    itemCount: _userData.length,
                    itemBuilder: (context, n){
                      DocumentSnapshot _ds = snapshot.data.documents[n];
                      int imagesLength = _ds['images'].length;
                      return AdCard(
                        type: _ds['type'],
                        postId: _ds.documentID,
                        deposit: _ds['deposit'],
                        rent: _ds['rent'],
                        location: _ds['location'],
                        currentUserId: this.widget.cUser.uid,
                        adUserId: _ds['userId'],
                        images: List.generate(
                            imagesLength,
                                (n){
                              return Image.network(_ds['images'][n]);
                            }
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('No ads for paying guests'),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
