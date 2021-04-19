import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';

class CalculatorResultScreen extends StatefulWidget {
  static const routeId = '/calculator-result';

  @override
  _CalculatorResultScreenState createState() => _CalculatorResultScreenState();
}

class _CalculatorResultScreenState extends State<CalculatorResultScreen> {
  final _formatCurrency =
      NumberFormat.simpleCurrency(locale: 'ko-KR', name: "", decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, value, child) {
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
                        MainTopText(
                          investDate: value.calculationResult.investDate,
                          companyName: value.calculationResult.name,
                        ),
                        MainBottomText(
                          investPrice: _formatCurrency
                              .format(value.calculationResult.investPrice),
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
                            EmojiYieldPriceText(
                              yieldPercent:
                                  value.calculationResult.yieldPercent,
                              yieldPrice: _formatCurrency
                                  .format(value.calculationResult.yieldPrice),
                            ),
                            YieldPercentText(
                              yieldPercent:
                                  value.calculationResult.yieldPercent,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '${value.calculationResult.oldCloseDate} 종가 기준',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '1주당 ${_formatCurrency.format(value.calculationResult.oldPrice)}원',
                                    style: kOldStockTextStyle,
                                  ),
                                  Container(
                                    height: 20,
                                    child: VerticalDivider(
                                      color: Color(0xff979797),
                                    ),
                                  ),
                                  Text(
                                    '${value.calculationResult.holdingStock.toStringAsFixed(1)}주 보유',
                                    style: kOldStockTextStyle,
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
                      child: SalaryYearMonthText(
                        salaryYear: _formatCurrency
                            .format(value.calculationResult.salaryYear),
                        salaryMonth: _formatCurrency.format(
                          value.calculationResult.salaryMonth,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SalaryYearMonthText extends StatelessWidget {
  final String salaryYear;
  final String salaryMonth;

  SalaryYearMonthText({this.salaryYear, this.salaryMonth});

  @override
  Widget build(BuildContext context) {
    return Row(
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
              salaryYear,
              style: kSalaryTextStyle,
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
              salaryMonth,
              style: kSalaryTextStyle,
            ),
          ],
        )
      ],
    );
  }
}

class YieldPercentText extends StatelessWidget {
  final int yieldPercent;

  YieldPercentText({this.yieldPercent});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: (yieldPercent > 0)
              ? Colors.red
              : (yieldPercent < 0)
                  ? Colors.blue
                  : Colors.black,
          fontSize: 26,
          fontWeight: FontWeight.w300,
        ),
        children: [
          (yieldPercent > 0) ? TextSpan(text: '+') : TextSpan(text: '-'),
          TextSpan(
            text: '$yieldPercent%',
          ),
        ],
      ),
    );
  }
}

class EmojiYieldPriceText extends StatelessWidget {
  final int yieldPercent;
  final String yieldPrice;

  EmojiYieldPriceText({this.yieldPercent, this.yieldPrice});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: (yieldPercent > 0)
              ? Colors.red
              : (yieldPercent < 0)
                  ? Colors.blue
                  : Colors.black,
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
        children: [
          (yieldPercent > 0)
              ? TextSpan(text: '😂 ')
              : (yieldPercent < 0)
                  ? TextSpan(text: '😱 ')
                  : TextSpan(text: '🤔 '),
          TextSpan(text: '$yieldPrice원'),
        ],
      ),
    );
  }
}

class MainBottomText extends StatelessWidget {
  final String investPrice;

  MainBottomText({this.investPrice});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 24,
          color: Colors.black,
          fontWeight: FontWeight.w300,
        ),
        children: <TextSpan>[
          TextSpan(
            text: investPrice,
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
    );
  }
}

class MainTopText extends StatelessWidget {
  final String investDate;
  final String companyName;

  MainTopText({this.investDate, this.companyName});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 24,
          color: Colors.black,
          fontWeight: FontWeight.w300,
        ),
        children: <TextSpan>[
          TextSpan(
            text: investDate,
            style: kMainBoldTextStyle,
          ),
          TextSpan(
            text: '에 ',
          ),
          TextSpan(
            text: companyName,
            style: kMainBoldTextStyle,
          ),
          TextSpan(
            text: '를',
          )
        ],
      ),
    );
  }
}
