import 'dart:async';

import 'package:flutter/material.dart';
import 'package:room_finder/src/values/constants.dart';

class ChatBoxLeft extends StatefulWidget {
  final String text;

  ChatBoxLeft({@required this.text});

  @override
  _ChatBoxLeftState createState() => _ChatBoxLeftState();
}

class _ChatBoxLeftState extends State<ChatBoxLeft>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: kDefaultPadding * 0.5,
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
        GestureDetector(
          onTap: () {
            _animationController.forward();
            Timer(Duration(seconds: 4), () {
              _animationController.reverse();
            });
          },
          child: Wrap(
            alignment: WrapAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.1,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding / 1.5,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor == Colors.black
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(kDefaultPadding),
                    bottomLeft: Radius.circular(kDefaultPadding),
                    bottomRight: Radius.circular(kDefaultPadding),
                  ),
                ),
                child: Text(
                  this.widget.text,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Theme.of(context).backgroundColor,
                        fontSize:
                            Theme.of(context).textTheme.subtitle1.fontSize,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
