import 'package:flutter/material.dart';

class OtherMessage extends StatelessWidget {
  final String message;
  OtherMessage({@required this.message});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          padding: EdgeInsets.all(14.0),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.6,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            message,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
