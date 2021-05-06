import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/calculator/calculator_dto.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';
import 'package:should_have_bought_app/utils.dart';

class CalculatorResultScreen extends StatefulWidget {
  static const routeId = '/calculator-result';

  @override
  _CalculatorResultScreenState createState() => _CalculatorResultScreenState();
}

class _CalculatorResultScreenState extends State<CalculatorResultScreen> {
  List<Color> colorSet;
  Color topColor;
  final List<String> _randomDates = [
    'DAY1',
    'WEEK1',
    'MONTH1',
    'MONTH6',
    'YEAR1',
    'YEAR5',
    'YEAR10'
  ];
  final List<String> _randomPrices = [
    '100000',
    '500000',
    '1000000',
    '5000000',
    '10000000'
  ];

  Widget randomValues(BuildContext context, Function onTap) {
    return InkWell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage('assets/icons/ico_random.png')),
          Padding(padding: EdgeInsets.only(bottom: 2)),
          Text(
            '랜덤',
            style: TextStyle(fontSize: 11, color: Color(0xFF828282)),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  void setBackgroundColor(int percent) {
    if (percent > 0) {
      colorSet = [
        Color(0xa0FF6561),
        Color(0x00FF6561),
      ];
      topColor = Color(0xa0FF6561);
    } else if (percent < 0) {
      colorSet = [
        Color(0xa04990FF),
        Color(0x004990FF),
      ];
      topColor = Color(0xa04990FF);
    } else {
      colorSet = [
        defaultBackgroundColor,
        defaultBackgroundColor,
      ];
      topColor = defaultBackgroundColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, value, child) {
        setBackgroundColor(value.calculationResult.yieldPercent);
        return Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 360,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: colorSet,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 40,
                    bottom: 30,
                    left: 12,
                    right: 20,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () => Navigator.of(context).pop('update'),
                      ),
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Color(0x80FFFFFF),
                        ),
                        child: randomValues(context, () {
                          final _companyList = value.companyList;
                          final _randomDate =
                              Random().nextInt(_randomDates.length);
                          final _randomCompnay =
                              Random().nextInt(_companyList.length);
                          final _randomPrice =
                              Random().nextInt(_randomPrices.length);
                          value.randomResult(CalculatorDto(
                            code: _companyList[_randomCompnay].code,
                            investDate: _randomDates[_randomDate],
                            investPrice:
                                intToCurrency(_randomPrices[_randomPrice]),
                          ).toMap());
                        }),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 110,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            MainTopText(
                              investDate: value.calculationResult.investDate,
                              companyName: value.calculationResult.name,
                            ),
                            MainBottomText(
                              investPrice: numberWithComma(
                                  value.calculationResult.investPrice),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 35),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 209,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFF1F1F1),
                                offset: Offset(2.0, 13.0),
                                blurRadius: 35.0,
                              ),
                            ],
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
                                  yieldPrice: numberWithComma(
                                      value.calculationResult.yieldPrice),
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
                                      AutoSizeText(
                                        '1주당 ${numberWithComma(value.calculationResult.oldPrice)}원',
                                        style: kOldStockTextStyle,
                                        maxLines: 1,
                                      ),
                                      Container(
                                        height: 20,
                                        child: VerticalDivider(
                                          color: Color(0xff979797),
                                        ),
                                      ),
                                      AutoSizeText(
                                        '${value.calculationResult.holdingStock.toStringAsFixed(1)}주 보유',
                                        style: kOldStockTextStyle,
                                        maxLines: 1,
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
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '연봉/월급으로 친다면?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 86,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffC2C2C2).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFF1F1F1),
                                offset: Offset(2.0, 13.0),
                                blurRadius: 35.0,
                              ),
                            ],
                          ),
                          child: SalaryYearMonthText(
                            salaryYear: numberWithComma(
                                value.calculationResult.salaryYear),
                            salaryMonth: numberWithComma(
                              value.calculationResult.salaryMonth,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
            AutoSizeText(
              '1년에',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xff828282),
              ),
              maxLines: 1,
            ),
            AutoSizeText(
              salaryYear,
              style: kSalaryTextStyle,
              maxLines: 1,
              minFontSize: 10,
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
            AutoSizeText(
              salaryMonth,
              style: kSalaryTextStyle,
              maxLines: 1,
              minFontSize: 10,
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
          (yieldPercent > 0)
              ? TextSpan(text: '+')
              : (yieldPercent < 0)
                  ? TextSpan(text: '-')
                  : TextSpan(),
          TextSpan(
            text: ' ${yieldPercent.abs()}%',
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
    return AutoSizeText.rich(
      TextSpan(
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
      minFontSize: 10,
      maxLines: 1,
    );
  }
}

class MainBottomText extends StatelessWidget {
  final String investPrice;

  MainBottomText({this.investPrice});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText.rich(
      TextSpan(
        style: TextStyle(
          fontSize: 24,
          color: Colors.black,
          fontWeight: FontWeight.w300,
        ),
        children: <TextSpan>[
          TextSpan(
            text: investPrice,
            style: kMainBoldTextStyle,
          ),
          TextSpan(
            text: '원 샀으면 지금..?',
          ),
        ],
      ),
      maxLines: 1,
      minFontSize: 10,
    );
  }
}

class MainTopText extends StatelessWidget {
  final String investDate;
  final String companyName;

  MainTopText({this.investDate, this.companyName});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText.rich(
      TextSpan(
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
      maxLines: 1,
      minFontSize: 10,
    );
  }
}
