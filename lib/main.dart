import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('room finder'),
        ),
        body: Container(
          child: Center(
            child: Text('test'),
          ),
        ),
      ),
    );
  }
}
