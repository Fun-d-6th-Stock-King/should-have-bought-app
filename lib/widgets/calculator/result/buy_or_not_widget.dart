import 'package:flutter/material.dart';

class BuyOrNotWidget extends StatefulWidget {
  @override
  _BuyOrNotWidgetState createState() => _BuyOrNotWidgetState();
}

class _BuyOrNotWidgetState extends State<BuyOrNotWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '살까?말까?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: <Widget>[
                  Text('더보기'),
                  Icon(Icons.keyboard_arrow_right_outlined),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 15),
        Text('한국타이어 테크놀로지 살래 말래?'),
        Container(
          height: 76,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13.0),
            color: Color(0xFFF8F8F8),
          ),
          child: Row(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ImageIcon(
                          AssetImage('assets/icons/ico_like_small.png'),
                          color: Colors.red,
                        ),
                        Text(
                          '살?',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                  height: 34, child: VerticalDivider(color: Color(0xFFDADADA)))
            ],
          ),
        ),
      ],
    );
  }
}
