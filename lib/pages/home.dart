import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('room finder'),
      ),
      body: Container(
        child: Center(
          child: MaterialButton(
            child: Text('settings'),
            onPressed: (){
              Navigator.pushNamed(context, '/setting');
            },
          ),
        ),
      ),
    );
  }
}
