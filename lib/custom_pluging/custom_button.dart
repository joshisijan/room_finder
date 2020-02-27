import 'package:flutter/material.dart';
import 'package:room_finder/functions/constants.dart';


class CustomButton extends StatelessWidget {

  final String title;
  final Function pressed;

  CustomButton({@required this.title, @required this.pressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: RawMaterialButton(
        fillColor: Theme.of(context).buttonColor,
        child: Text(this.title),
        onPressed: this.pressed,
      ),
    );
  }
}
