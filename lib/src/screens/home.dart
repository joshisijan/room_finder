import 'package:flutter/material.dart';
import 'package:room_finder/src/values/constants.dart';
import 'package:room_finder/src/tabs/account_tab.dart';
import 'package:room_finder/src/tabs/home_tab.dart';
import 'package:room_finder/src/tabs/message_tab.dart';
import 'package:room_finder/src/tabs/post_tab.dart';
import 'package:room_finder/src/tabs/search_tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageStorageBucket bucket = PageStorageBucket();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
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
      body: PageStorage(
        bucket: bucket,
        child: changeTab(_currentIndex),
      ),
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
            label: 'My Account',
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
