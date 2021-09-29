import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/src/reuseables/notification.dart';
import 'package:room_finder/src/reuseables/other_message.dart';
import 'package:room_finder/src/reuseables/own_message.dart';
import 'package:room_finder/src/screens/message_ad_detail.dart';
import 'package:room_finder/src/values/constants.dart';

class MessageContainer extends StatefulWidget {
  final String otherUid;
  final String adId;
  final Map<String, dynamic> adDetail;

  MessageContainer({
    @required this.otherUid,
    @required this.adId,
    @required this.adDetail,
  });
  @override
  State<MessageContainer> createState() => _MessageContainerState();
}

class User {}

class _MessageContainerState extends State<MessageContainer> {
  String adUserName = 'Loading...';

  TextEditingController _messageController;
  FocusNode _messageFocus;

  getAdUserName() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    firebaseFirestore
        .collection('users')
        .doc(widget.otherUid)
        .get()
        .then((value) {
      var data = value.data();
      if (data != null) {
        setState(() {
          adUserName = data['displayName'];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _messageFocus = FocusNode();
    getAdUserName();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _messageFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(adUserName),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .where('adId', isEqualTo: widget.adId)
                  .where('participant', arrayContainsAny: [
                    FirebaseAuth.instance.currentUser.uid,
                    widget.otherUid
                  ])
                  .orderBy('createdOn', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.data == null ||
                      snapshot.data.documents.length <= 0) {
                    return Center(
                      child: Text('No message yet'),
                    );
                  }
                  var datas = snapshot.data.documents;
                  return ListView(
                    padding: EdgeInsets.all(kDefaultPadding),
                    reverse: true,
                    children: datas.map<Widget>((data) {
                      String currentUserId =
                          FirebaseAuth.instance.currentUser.uid;
                      if (currentUserId == data['userId']) {
                        return OwnMessage(message: data['message'].toString());
                      } else {
                        return OtherMessage(
                            message: data['message'].toString());
                      }
                    }).toList(),
                  );
                }
              },
            ),
          ),
          Container(
            color: Theme.of(context).primaryColorLight.withAlpha(100),
            child: MessageAdDetail(
              adId: widget.adId,
              latLng: widget.adDetail['latLng'],
              adUserId: widget.adDetail['adUserId'],
              currentUserId: FirebaseAuth.instance.currentUser.uid,
              deposit: widget.adDetail['deposit'],
              rent: widget.adDetail['rent'],
              postId: widget.adDetail['postId'],
              type: widget.adDetail['type'],
              terms: widget.adDetail['terms'],
              images: widget.adDetail['images'],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight.withAlpha(100),
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).primaryColorDark,
                  ),
                )),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _messageController,
                    focusNode: _messageFocus,
                    minLines: 1,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    handleMessageSend();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  handleMessageSend() async {
    if (_messageController.text.isEmpty) {
      CustomNotification(
        color: Theme.of(context).errorColor,
        message: 'Enter something first',
        title: 'Empty message',
      ).show(context);
    } else {
      FirebaseFirestore.instance.collection('messages').add({
        'message': _messageController.text.trim(),
        'adId': widget.adId,
        'participant': [
          FirebaseAuth.instance.currentUser.uid,
          widget.otherUid,
        ],
        'otherId': widget.otherUid,
        'userId': FirebaseAuth.instance.currentUser.uid,
        'createdOn': FieldValue.serverTimestamp(),
      });
      _messageFocus.unfocus();
      _messageController.text = "";
    }
  }
}
