import 'dart:async';

import 'package:flutter/material.dart';
import 'package:room_finder/src/values/constants.dart';

class ChatBoxRight extends StatefulWidget {

  final String text;

  ChatBoxRight({@required this.text});

  @override
  _ChatBoxRightState createState() => _ChatBoxRightState();
}

class _ChatBoxRightState extends State<ChatBoxRight> with SingleTickerProviderStateMixin{

  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        SizedBox(
          height: kDefaultPadding * 0.5,
        ),
        GestureDetector(
          onTap: (){
            _animationController.forward();
            Timer(
              Duration(seconds: 4),(){
                _animationController.reverse();
              }
            );
          },
          child: Wrap(
            alignment: WrapAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding / 1.5,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .color
                      .withAlpha(kDefaultPadding.toInt() * 2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kDefaultPadding),
                    topRight: Radius.circular(kDefaultPadding),
                    bottomLeft: Radius.circular(kDefaultPadding),
                  ),
                ),
                child: Text(
                  this.widget.text,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: Theme.of(context).textTheme.subtitle2.fontSize,
                  ),
                ),
              ),
            ],
          ),
        ),
        FadeTransition(
          opacity: _animation,
          child: Text(
            '2017-12-11 10:10',
            style: Theme.of(context).textTheme.caption.copyWith(
              fontSize: Theme.of(context).textTheme.caption.fontSize * .9,
            ),
          ),
        ),
      ],
    );
  }
}
