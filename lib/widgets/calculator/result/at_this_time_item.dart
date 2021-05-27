import 'dart:math';
import 'package:flutter/material.dart';
import 'package:should_have_bought_app/models/calculator/calculator_stock.dart';
import 'package:should_have_bought_app/utils.dart';

class AtThisTimeItem extends StatefulWidget {
  final String date;
  final CalculatorStock calculatorResult;

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
    if (widget.calculatorResult == null) {
      return Center(child: Text('${_dateTable[widget.date]} 데이터가 없어요!'));
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${widget.calculatorResult.oldCloseDate} 종가 기준',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            '${_dateTable[widget.date]} ${convertMoney(widget.calculatorResult.investPrice)}원 샀으면 지금',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '${numberWithComma(widget.calculatorResult.yieldPrice.toString())}원',
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
                    color:
                        getYieldBoxColor(widget.calculatorResult.yieldPercent),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${getYieldMoney()} (${getYieldPercent(widget.calculatorResult.yieldPercent)})',
                      style: TextStyle(
                        color: getYieldTextColor(
                            widget.calculatorResult.yieldPercent),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            '${numberWithComma(widget.calculatorResult.oldPrice.toString())}/1주',
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

  String getYieldMoney() {
    final yieldPrice = (double.parse(widget.calculatorResult.yieldPrice) -
        double.parse(widget.calculatorResult.investPrice));
    if (yieldPrice > 0) {
      return '+ ${numberWithComma(yieldPrice.toStringAsFixed(0))}';
    } else if (yieldPrice < 0) {
      return '- ${numberWithComma(yieldPrice.abs().toStringAsFixed(0))}';
    } else {
      return '${numberWithComma(yieldPrice.abs().toStringAsFixed(0))}';
    }
  }

  String getYieldPercent(int percent) {
    if (percent > 0) {
      return '+ $percent%';
    } else if (percent < 0) {
      return '- $percent%';
    } else {
      return '$percent%';
    }
  }

  Color getYieldBoxColor(int percent) {
    if (percent > 0) {
      return Color(0xffFFEFF0);
    } else if (percent < 0) {
      return Color(0xFF0055FF).withOpacity(0.07);
    } else {
      return Colors.white;
    }
  }

  Color getYieldTextColor(int percent) {
    if (percent > 0) {
      return Colors.red;
    } else if (percent < 0) {
      return Color(0XFF0055FF);
    } else {
      return Colors.black;
    }
  }
}
