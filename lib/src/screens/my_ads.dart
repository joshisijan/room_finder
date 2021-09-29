import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:room_finder/src/reuseables/cache_image.dart';
import 'package:room_finder/src/reuseables/own_ad_card.dart';

class MyAds extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('My Ads'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('ads')
            .where('userId', whereIn: [user.uid]).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data == null || snapshot.data.documents.length <= 0) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: Center(
                  child: Text('No Ads posted yet'),
                ),
              );
            }
            var datas = snapshot.data.documents;
            return Column(
              children: datas.map<Widget>((data) {
                return OwnAdCard(
                  id: data.id,
                  latLng: LatLng(data['lat'], data['lng']),
                  adUserId: data['userId'],
                  currentUserId: user.uid,
                  deposit: data['deposit'],
                  rent: data['rent'],
                  postId: data.reference.documentID,
                  type: data['type'],
                  terms: data['terms'],
                  images: List.generate(
                    4,
                    (index) {
                      int i = index + 1;
                      if (data['file$i'] != '') {
                        return CustomCacheImage(imageUrl: data['file$i']);
                      }
                      return null;
                    },
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
