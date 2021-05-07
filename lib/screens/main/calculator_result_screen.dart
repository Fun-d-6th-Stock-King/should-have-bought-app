import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/calculator/calculator_dto.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';
import 'package:should_have_bought_app/utils.dart';

import 'package:should_have_bought_app/widgets/calculator/result/loading_random_widget.dart';
import 'package:should_have_bought_app/widgets/calculator/result/random_widget.dart';
import 'package:should_have_bought_app/widgets/calculator/result/salary_year_month_widget.dart';
import 'package:should_have_bought_app/widgets/calculator/result/ten_year_widget.dart';

class CalculatorResultScreen extends StatefulWidget {
  static const routeId = '/calculator-result';

  @override
  _CalculatorResultScreenState createState() => _CalculatorResultScreenState();
}

class _CalculatorResultScreenState extends State<CalculatorResultScreen> {
  Color textColor;
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
  bool isLoading = false;

  void setBackgroundColor() {
    final percent =
        Provider.of<CalculatorProvider>(context).calculationResult.yieldPercent;
    if (percent > 0) {
      topColor = Color(0xffFF6561);
      textColor = Colors.white;
    } else if (percent < 0) {
      topColor = Color(0xff4990FF);
      textColor = Colors.white;
    } else {
      topColor = Color(0xffF2F2F2);
      textColor = Colors.black;
    }
  }

  void randomValues() {
    setState(() {
      isLoading = true;
    });
    final _companyList =
        Provider.of<CalculatorProvider>(context, listen: false).companyList;
    final _randomDate = Random().nextInt(_randomDates.length);
    final _randomCompnay = Random().nextInt(_companyList.length);
    final _randomPrice = Random().nextInt(_randomPrices.length);
    Provider.of<CalculatorProvider>(context, listen: false)
        .randomResult(CalculatorDto(
      code: _companyList[_randomCompnay].code,
      investDate: _randomDates[_randomDate],
      investPrice: intToCurrency(_randomPrices[_randomPrice]),
    ).toMap())
        .then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    setBackgroundColor();
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            CustomPaint(
              painter: MyPainter(topColor),
              size: Size(1200, 1200),
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
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Color(0x80FFFFFF),
                    ),
                    child: isLoading
                        ? LoadingRandomWidget()
                        : RandomWidget(onTap: () {
                            randomValues();
                          }),
                  ),
                ],
              ),
            ),
            Container(
              height: 360,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Image(
                      image: AssetImage('assets/images/plus_chick.png'),
                    ),
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
                          textColor: textColor,
                        ),
                        MainMidText(
                          textColor: textColor,
                        ),
                        MainBottomText(
                          textColor: textColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 75),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 209,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x1F5A5A5A),
                            offset: Offset(6.0, 8.0),
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
                            EmojiYieldPriceText(),
                            YieldPercentText(),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '${Provider.of<CalculatorProvider>(context).calculationResult.oldCloseDate} 종가 기준',
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
                                    '1주당 ${numberWithComma(Provider.of<CalculatorProvider>(context).calculationResult.oldPrice)}원',
                                    style: kOldStockTextStyle,
                                    minFontSize: 15,
                                    maxLines: 1,
                                  ),
                                  Container(
                                    height: 20,
                                    child: VerticalDivider(
                                      color: Color(0xff979797),
                                    ),
                                  ),
                                  AutoSizeText(
                                    '${Provider.of<CalculatorProvider>(context).calculationResult.holdingStock.toStringAsFixed(1)}주 보유',
                                    style: kOldStockTextStyle,
                                    minFontSize: 15,
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
                  Provider.of<CalculatorProvider>(context)
                              .calculationResult
                              .yieldPercent >
                          0
                      ? SalaryYearMonthWidget(
                          salaryYear: Provider.of<CalculatorProvider>(context)
                              .calculationResult
                              .salaryYear,
                          salaryMonth: Provider.of<CalculatorProvider>(context)
                              .calculationResult
                              .salaryMonth,
                        )
                      : TenYearWidget(
                          money: convertMoney(
                              Provider.of<CalculatorProvider>(context)
                                  .calculationResult
                                  .investPrice),
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class YieldPercentText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final yieldPercent =
        Provider.of<CalculatorProvider>(context).calculationResult.yieldPercent;
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
          TextSpan(
            text: '(${yieldPercent.abs()}%)',
          ),
        ],
      ),
    );
  }
}

class EmojiYieldPriceText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final yieldPercent =
        Provider.of<CalculatorProvider>(context).calculationResult.yieldPercent;
    final yieldPrice = numberWithComma(
        Provider.of<CalculatorProvider>(context).calculationResult.yieldPrice);
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
          (yieldPercent > 0) ? TextSpan(text: '+ ') : TextSpan(text: '- '),
          TextSpan(text: '$yieldPrice원'),
        ],
      ),
      minFontSize: 10,
      maxLines: 1,
    );
  }
}

class MainBottomText extends StatelessWidget {
  final Color textColor;

  MainBottomText({this.textColor});

  @override
  Widget build(BuildContext context) {
    final investPrice = numberWithComma(
        Provider.of<CalculatorProvider>(context).calculationResult.investPrice);
    return AutoSizeText.rich(
      TextSpan(
        style: TextStyle(
          fontSize: 24,
          color: textColor,
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
  final Color textColor;

  MainTopText({this.textColor});

  @override
  Widget build(BuildContext context) {
    final investDate =
        Provider.of<CalculatorProvider>(context).calculationResult.investDate;
    return AutoSizeText.rich(
      TextSpan(
        style: TextStyle(
          fontSize: 24,
          color: textColor,
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
        ],
      ),
      maxLines: 1,
      minFontSize: 10,
    );
  }
}

class MainMidText extends StatelessWidget {
  final Color textColor;

  MainMidText({this.textColor});

  @override
  Widget build(BuildContext context) {
    final companyName =
        Provider.of<CalculatorProvider>(context).calculationResult.name;
    return AutoSizeText.rich(
      TextSpan(
        style: TextStyle(
          fontSize: 24,
          color: textColor,
          fontWeight: FontWeight.w300,
        ),
        children: <TextSpan>[
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

// This is the Painter class
class MyPainter extends CustomPainter {
  final Color topColor;
  MyPainter(this.topColor);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = topColor;
    var path = Path();

    path.moveTo(0, size.height * 0.3);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2.5, size.width, size.height * 0.3);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
