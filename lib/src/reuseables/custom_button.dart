import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:room_finder/src/values/constants.dart';


class CustomButton extends StatelessWidget {

  final Widget title;
  final Function pressed;
  final bool padded;
  final Color bgColor;

  CustomButton({@required this.title, @required this.pressed, @required this.padded, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: this.padded ? kDefaultPadding : 0.0),
      child: MaterialButton(
        color: this.bgColor ?? Theme.of(context).buttonColor,
        textColor: Theme.of(context).backgroundColor,
        child: this.title,
        onPressed: this.pressed,
      ),
    );
  }
}
