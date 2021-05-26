import 'package:flutter/material.dart';
import 'package:should_have_bought_app/utils.dart';

class AtThisTimeItem extends StatefulWidget {
  final String date;
  final Map calculatorResult;

  const AtThisTimeItem({this.date, this.calculatorResult});

  @override
  _AtThisTimeItemState createState() => _AtThisTimeItemState();
}

class _AtThisTimeItemState extends State<AtThisTimeItem> {
  final _dateTable = {
    'DAY1': '어제',
    'WEEK1': '저번 주에',
    'YEAR1': '작년에',
    'YEAR10': '10년전에'
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${_dateTable[widget.date]} ${convertMoney('100000')}원 샀으면 지금',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '1,840,412원',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Container(
                  height: 30,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    color: Color(0xFF0055FF).withOpacity(0.07),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '- 4,123,180원(-145%)',
                      style: TextStyle(
                        color: Color(0XFF0055FF),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            '18,380원/1주',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
