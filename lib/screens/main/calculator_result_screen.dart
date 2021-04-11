import 'package:flutter/material.dart';

class CalculatorResultScreen extends StatefulWidget {
  @override
  _CalculatorResultScreenState createState() => _CalculatorResultScreenState();
}

class _CalculatorResultScreenState extends State<CalculatorResultScreen> {
  final _dummy = {
    "code": "005930",
    "company": "삼성전자",
    "currentPrice": 85600,
    "lastTradingDateTime": "2021 Apr 07 15:30:24",
    "calculationResult": {
      "investDate": "10년전",
      "investPrice": 100000,
      "yieldPrice": 470847.08,
      "yieldPercent": 370.8471,
      "oldCloseDate": "2011.04.07",
      "oldPrice": 18180,
      "holdingStock": 5.50055,
      "salaryYear": 47084.71,
      "salaryMonth": 3923.726
    }
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('그때 살껄'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.refresh),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: <Widget>[
              Text('hh'),
            ],
          ),
        ),
      ),
    );
  }
}
