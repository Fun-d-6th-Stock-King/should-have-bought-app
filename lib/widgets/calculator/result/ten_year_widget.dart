import 'package:flutter/material.dart';

class TenYearWidget extends StatelessWidget {
  final String day;
  final String money;

  TenYearWidget({this.day, this.money});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '$day? $money원 이면...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
