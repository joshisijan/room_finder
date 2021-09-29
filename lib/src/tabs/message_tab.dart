import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:room_finder/src/reuseables/ad_card.dart';
import 'package:room_finder/src/reuseables/cache_image.dart';

class MessageTab extends StatefulWidget {
  @override
  State<MessageTab> createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab> {
  final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('messages')
            .where(
              'participant',
              arrayContains: FirebaseAuth.instance.currentUser.uid,
            )
            .orderBy('createdOn', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data == null || snapshot.data.documents.length <= 0) {
              return Center(
                child: Text('No message yet'),
              );
            }
            var datas = snapshot.data.documents;
            List<String> adIds = [];
            datas.forEach((data) {
              if (!adIds.contains(data['adId'])) {
                adIds.add(data['adId']);
              }
            });
            return ListView(
              children: adIds.map((adId) {
                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('ads')
                        .doc(adId)
                        .get()
                        .asStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SizedBox.shrink(),
                        );
                      } else {
                        if (snapshot.data == null) {
                          return Center(
                            child: SizedBox.shrink(),
                          );
                        } else {
                          var data = snapshot.data;
                          return AdCard(
                            adId: adId,
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
                                  return CustomCacheImage(
                                      imageUrl: data['file$i']);
                                }
                                return null;
                              },
                            ),
                          );
                        }
                      }
                    });
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
