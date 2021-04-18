import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/calculator_stock.dart';

class CalculatorResultScreen extends StatefulWidget {
  static const routeId = '/calculator-result';

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
  final _formatCurrency =
      NumberFormat.simpleCurrency(locale: 'ko-KR', name: "", decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    var _stockData = CalculatorStock.fromMap(_dummy);
    var _yieldPercent = _stockData.calculationResult['yieldPercent'];
    return Scaffold(
      appBar: AppBar(
        title: Text('그때 살껄'),
        elevation: 0.0,
        backgroundColor: defaultBackgroundColor,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                '${_stockData.calculationResult['investDate']}',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: '에',
                          ),
                          TextSpan(
                            text: ' ${_stockData.name}',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: '를',
                          )
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: _formatCurrency.format(
                                _stockData.calculationResult['investPrice']),
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: '원에 샀으면 지금..?',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 35),
              Container(
                height: 209,
                width: 321,
                child: Card(
                  elevation: 0.4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 18,
                      right: 18,
                      top: 18,
                    ),
                    child: Column(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: (_yieldPercent > 0)
                                  ? Colors.red
                                  : (_yieldPercent < 0)
                                      ? Colors.blue
                                      : Colors.black,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              (_yieldPercent > 0)
                                  ? TextSpan(text: '😂 ')
                                  : (_yieldPercent < 0)
                                      ? TextSpan(text: '😱 ')
                                      : TextSpan(text: '🤔 '),
                              TextSpan(
                                  text:
                                      '${_formatCurrency.format(_stockData.calculationResult['yieldPrice'])}원'),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: (_yieldPercent > 0)
                                  ? Colors.red
                                  : (_yieldPercent < 0)
                                      ? Colors.blue
                                      : Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.w300,
                            ),
                            children: [
                              (_yieldPercent > 0)
                                  ? TextSpan(text: '+')
                                  : TextSpan(text: '-'),
                              TextSpan(
                                text: '${_yieldPercent.toStringAsFixed(0)}%',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          '${_stockData.calculationResult['oldCloseDate']} 종가 기준',
                          style: TextStyle(
                            color: Color(0xff949597),
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          height: 31,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '1주당 27,050원',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                height: 20,
                                child: VerticalDivider(
                                  color: Color(0xff979797),
                                ),
                              ),
                              Text(
                                '3.6주 보유',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                '연봉/월급으로 친다면?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                width: 320,
                height: 86,
                child: Card(
                  elevation: 0.3,
                  color: Color(0xffF8F8F8).withOpacity(0.89),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '1년에',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff828282),
                            ),
                          ),
                          Text(
                            _formatCurrency.format(
                                _stockData.calculationResult['salaryYear']),
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 57,
                        child: VerticalDivider(
                          color: Color(0xff979797),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '1달에',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff828282),
                            ),
                          ),
                          Text(
                            _formatCurrency.format(
                                _stockData.calculationResult['salaryMonth']),
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
