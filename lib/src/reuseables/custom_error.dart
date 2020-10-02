import 'package:flutter/material.dart';
import 'package:room_finder/src/values/constants.dart';

class CustomError extends StatelessWidget {
  final String title;
  final EdgeInsets margin;
  CustomError({@required this.title, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).errorColor,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      margin: this.margin,
      child: Text(
        this.title,
        style: TextStyle(
          color: Colors.white,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
