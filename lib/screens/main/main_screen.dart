import 'package:flutter/material.dart';
import 'package:should_have_bought_app/widgets/hey_you_too.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 27,
              horizontal: 20,
            ),
            child: HeyYouToo(),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 13.5,
              horizontal: 20,
            ),
            child: HeyYouToo(),
          ),
        ],
      ),
    );
  }
}
