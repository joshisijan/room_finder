import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/src/reuseables/custom_button.dart';
import 'package:room_finder/src/reuseables/notification.dart';
import 'package:room_finder/src/screens/edit_profile.dart';
import 'package:room_finder/src/values/constants.dart';
import 'package:room_finder/src/tabs/account_tab.dart';
import 'package:room_finder/src/tabs/home_tab.dart';
import 'package:room_finder/src/tabs/message_tab.dart';
import 'package:room_finder/src/tabs/post_tab.dart';
import 'package:room_finder/src/tabs/search_tab.dart';

class HomePage extends StatefulWidget {
  int currentIndex;
  HomePage({Key key, this.currentIndex = 0}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageStorageBucket bucket = PageStorageBucket();
  bool verified = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;
    if (user.emailVerified == true)
      verified = true;
    else
      verified = false;
    if (verified == false) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Verification'),
          bottom: loading ? PreferredSize(
            preferredSize: Size.fromHeight(4.0),
            child: LinearProgressIndicator(minHeight: 4.0,),
          ) : null,
        ),
        body: AbsorbPointer(
          absorbing: loading,
          child: Opacity(
            opacity: loading ? 0.6 : 1.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      'Your email address has not been verified. Verify your email address and press verify button to get access to the app.',
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  CustomButton(
                    padded: true,
                    title: Text('Send Verification Code'),
                    pressed: () async {
                      setState(() {
                        loading = true;
                      });
                      try {
                        await user.sendEmailVerification();
                      } catch (e) {
                        CustomNotification(
                          color: Colors.green,
                          title: 'Error',
                          message: 'An error occurred.',
                        ).show(context);
                      }
                      CustomNotification(
                        color: Colors.green,
                        title: 'Verification',
                        message: 'Verification email sent to ${user.email}',
                      ).show(context);
                      setState(() {
                        loading = false;
                      });
                    },
                  ),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  CustomButton(
                    padded: true,
                    title: Text('Verify'),
                    pressed: () async {
                      setState(() {
                        loading = true;
                      });
                      await user.reload();
                      setState(() {
                        loading = false;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }else if(user.displayName == '' || user.displayName == null){
      return EditProfile(currentIndex: 0,);
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Room Finder'),
        actions: <Widget>[
          widget.currentIndex == 0 || widget.currentIndex == 1
              ? IconButton(
                  icon: Icon(Icons.map),
                  onPressed: () {},
                )
              : SizedBox(),
          SizedBox(
            width: kDefaultPadding / 2,
          ),
        ],
      ),
      body: IndexedStack(
        index: widget.currentIndex,
        children: [
          HomeTab(),
          SearchTab(),
          PostTab(),
          MessageTab(),
          AccountTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.currentIndex,
        onTap: (n) {
          if (n != widget.currentIndex) {
            setState(() {
              widget.currentIndex = n;
            });
          }
        },
        selectedFontSize: Theme.of(context).textTheme.caption.fontSize,
        selectedItemColor: Theme.of(context).accentColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Post Ads',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  Widget changeTab(int n) {
    if (n == 0) {
      return HomeTab();
    } else if (n == 1) {
      return SearchTab();
    } else if (n == 2) {
      return PostTab();
    } else if (n == 3) {
      return MessageTab();
    }
    return AccountTab();
  }
}