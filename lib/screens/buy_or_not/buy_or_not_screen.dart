import 'package:flutter/material.dart';
import 'package:should_have_bought_app/widgets/appbar/default_appbar.dart';

class BuyOrNotScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Text(
              '살까? 말까?',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Container(),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}
