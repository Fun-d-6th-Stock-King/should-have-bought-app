import 'package:flutter/material.dart';

class BestPriceWidget extends StatefulWidget {
  @override
  _BestPriceWidgetState createState() => _BestPriceWidgetState();
}

class _BestPriceWidgetState extends State<BestPriceWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '기간 내 최고가에 팔았다면?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Color(0xFFAEAEAE).withOpacity(0.16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                height: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
                  color: Color(0xFFAEAEAE).withOpacity(0.10),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('10만원 샀으면'),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 30,
                          color: Color(0xFFFF6B76),
                        ),
                        children: [
                          TextSpan(
                            text: '457,466원',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(text: '(+357%)'),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Text(
                          '보유기간',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          height: 16,
                          width: 1,
                          child: Divider(
                            thickness: 7,
                          ),
                          color: Color(0xFF8E8E8E).withOpacity(0.1),
                        ),
                        Text(
                          '9년 13일',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '2011.03.10~2021.01.11',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF949597),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
