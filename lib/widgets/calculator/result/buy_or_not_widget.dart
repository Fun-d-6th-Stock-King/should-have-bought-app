import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/utils.dart';
import 'package:should_have_bought_app/widgets/text/prod_and_cons_widget.dart';

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
                style: kResultTitleStyle,
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
        SizedBox(height: 10),
        Container(
          height: 76,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13.0),
            color: Color(0xFFAEAEAE).withOpacity(0.16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconWithNumber(
                icon: AssetImage('assets/icons/ico_like_small.png'),
                text: '살?',
                number: 32547,
                color: Colors.red,
              ),
              Container(
                height: 34,
                child: VerticalDivider(
                  color: Color(0xFFDADADA),
                ),
              ),
              IconWithNumber(
                icon: AssetImage('assets/icons/ico_unlike_small.png'),
                text: '말?',
                number: 1234,
                color: Colors.blue,
              ),
            ],
          ),
        ),
        SizedBox(height: 15.0),
      ],
    );
  }
}

class IconWithNumber extends StatelessWidget {
  final AssetImage icon;
  final String text;
  final int number;
  final Color color;

  const IconWithNumber({this.icon, this.text, this.number, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageIcon(
                icon,
                color: color,
                size: 15.0,
              ),
              SizedBox(width: 2.0),
              Text(
                text,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text(
              numberWithComma(
                number.toString(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
