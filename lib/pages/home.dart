import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/functions/constants.dart';
import 'package:room_finder/pages/login.dart';
import 'package:room_finder/tabs/account_tab.dart';
import 'package:room_finder/tabs/home_tab.dart';
import 'package:room_finder/tabs/message_tab.dart';
import 'package:room_finder/tabs/post_tab.dart';
import 'package:room_finder/tabs/search_tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageStorageBucket bucket = PageStorageBucket();

  final FirebaseAuth _fbAuth = FirebaseAuth.instance;

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: _fbAuth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Room Finder'),
                actions: <Widget>[
                  _currentIndex == 0 || _currentIndex == 1 ? IconButton(
                    icon: Icon(Icons.map),
                    onPressed: (){

                    },
                  ) : SizedBox(),
                  SizedBox(
                    width: kDefaultPadding / 2,
                  ),
                ],
              ),
              body: FutureBuilder(
                  future: _fbAuth.currentUser(),
                  builder: (context, snapshot1) {
                    if (snapshot1.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Text('Loading...'),
                      );
                    } else {
                      return PageStorage(
                        bucket: bucket,
                        child: changeTab(_currentIndex, snapshot1.data),
                      );
                    }
                  }),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: _currentIndex,
                onTap: (n) {
                  if(n != _currentIndex){
                    setState(() {
                      _currentIndex = n;
                    });
                  }
                },
                selectedFontSize: Theme.of(context).textTheme.caption.fontSize,
                selectedItemColor: Theme.of(context).accentColor,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    title: Text('Home'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    title: Text('Search'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add),
                    title: Text('Post Ads'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.message),
                    title: Text('Inbox'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    title: Text('Account'),
                  ),
                ],
              ),
            );
          } else {
            return LoginPage();
          }
        });
  }

  Widget changeTab(int n, FirebaseUser user) {
    if (n == 0) {
      return HomeTab(cUser: user);
    } else if (n == 1) {
      return SearchTab(cUser: user);
    } else if (n == 2) {
      return PostTab(cUser: user);
    } else if (n == 3) {
      return MessageTab(cUser: user);
    }
    return AccountTab(cUser: user);
  }
}
