import 'package:flutter/material.dart';

class OwnMessage extends StatelessWidget {
  final String message;
  OwnMessage({@required this.message});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.end,
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
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            message,
          ),
        ),
      ],
    );
  }
}
