import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';

class FlatBackgroundFrame extends StatelessWidget {
  final Widget child;
  FlatBackgroundFrame({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(children: [
          Container(
            height: 225,
            decoration: BoxDecoration(
              color: mainColor,
            ),
          ),
          child
        ]),
      ],
    );
  }
}