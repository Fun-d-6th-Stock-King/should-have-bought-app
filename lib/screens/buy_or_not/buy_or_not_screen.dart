import 'package:flutter/material.dart';

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
