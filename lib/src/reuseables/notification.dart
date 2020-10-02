import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';


class CustomNotification {
  final String title;
  final String message;
  final Color color;
  CustomNotification({@required this.title, @required this.message, @required this.color});
  show(BuildContext  context){
    Flushbar(
      title: title,
      message: message,
      backgroundColor: color,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      duration: Duration(seconds: 4),
      margin: EdgeInsets.zero,
    )..show(context);
  }
}
