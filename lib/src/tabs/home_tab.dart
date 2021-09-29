import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:room_finder/src/reuseables/ad_card.dart';
import 'package:room_finder/src/reuseables/cache_image.dart';
import 'package:room_finder/src/values/constants.dart';

// ignore: must_be_immutable
class HomeTab extends StatelessWidget {
  User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;
    return Container(
      child: ListView(children: <Widget>[
        Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Hello ${user.displayName}',
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
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('ads')
              .where('userId', whereNotIn: [user.uid]).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              if (snapshot.data == null ||
                  snapshot.data.documents.length <= 0) {
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
                  return AdCard(
                    adId: data.id,
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
        )
      ]),
    );
  }
}
