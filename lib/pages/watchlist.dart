import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/custom_pluging/ad_card.dart';


class WatchList extends StatefulWidget{

  final FirebaseUser cUser;

  WatchList({@required this.cUser});

  @override
  _WatchListState createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> with SingleTickerProviderStateMixin{

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
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
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
          Container(),
          Container(),
          Container()
        ],
      ),
    );
  }
}
