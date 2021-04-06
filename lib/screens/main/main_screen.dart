import 'package:flutter/material.dart';
import 'package:should_have_bought_app/widgets/hey_you_too.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 13.5,
              ),
              child: HeyYouToo(),
            ),
          ],
        ),
      ),
    );
  }
}
