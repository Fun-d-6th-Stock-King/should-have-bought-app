import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/calculator/calculator_dto.dart';
import 'package:should_have_bought_app/models/calculator/calculator_stock.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';
import 'package:should_have_bought_app/screens/drip_room/drip_room_screen.dart';
import 'package:should_have_bought_app/utils.dart';
import 'package:should_have_bought_app/widgets/calculator/result/current_value_widget.dart';
import 'package:should_have_bought_app/widgets/calculator/result/increase_rate_tab_widget.dart';

import 'package:should_have_bought_app/widgets/calculator/result/loading_random_widget.dart';
import 'package:should_have_bought_app/widgets/calculator/result/random_widget.dart';
import 'package:should_have_bought_app/widgets/calculator/result/salary_year_month_widget.dart';
import 'package:should_have_bought_app/widgets/calculator/result/ten_year_invest_chart_widget.dart';
import 'package:should_have_bought_app/widgets/calculator/result/at_this_time_widget.dart';
import 'package:should_have_bought_app/widgets/calculator/result/best_price_widget.dart';
import 'package:should_have_bought_app/widgets/calculator/result/should_bought_this_widget.dart';
import 'package:should_have_bought_app/widgets/calculator/result/buy_or_not_widget.dart';

class CalculatorResultScreen extends StatefulWidget {
  static const routeId = '/calculator-result';

  @override
  _CalculatorResultScreenState createState() => _CalculatorResultScreenState();
}

class _CalculatorResultScreenState extends State<CalculatorResultScreen> {
  Color textColor;
  Color topColor;
  AssetImage chickImage;

  bool isLoading = false;

  void setDynamicOption() {
    final percent = Provider.of<CalculatorProvider>(context, listen: false)
        .calculationResult
        .yieldPercent;
    if (percent > 0) {
      setState(() {
        topColor = Color(0xffFF6561);
        textColor = Colors.white;
        chickImage = AssetImage('assets/images/plus_chick.png');
      });
    } else if (percent < 0) {
      setState(() {
        topColor = Color(0xff4990FF);
        textColor = Colors.white;
        chickImage = AssetImage('assets/images/minus_chick.png');
      });
    } else {
      setState(() {
        topColor = Color(0xffF2F2F2);
        textColor = Colors.black;
        chickImage = AssetImage('assets/images/normal_chick.png');
      });
    }
  }

  void setChick() {}

  void randomValues() {
    setState(() {
      isLoading = true;
    });

    final _companyList =
        Provider.of<CalculatorProvider>(context, listen: false).companyList;
    final _randomDate = Random().nextInt(dates.length);
    final _randomCompnay = Random().nextInt(_companyList.length);
    final _randomPrice = Random().nextInt(prices.length);
    Provider.of<CalculatorProvider>(context, listen: false)
        .randomResult(CalculatorDto(
      code: _companyList[_randomCompnay].code,
      investDate: dates[_randomDate],
      investPrice: intToCurrency(prices[_randomPrice]),
    ).toMap())
        .then((_) {
      setDynamicOption();
      setState(() {
        isLoading = false;
      });
    });

    reBuildApi();
  }

  @override
  void initState() {
    reBuildApi();
    super.initState();
  }

  void reBuildApi() {
    Provider.of<CalculatorProvider>(context, listen: false).getSectorData();
    Provider.of<CalculatorProvider>(context, listen: false).getTenYearHigher();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    setDynamicOption();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Frame(child: CalculatorResultWidget()),
          SizedBox(height: 50),
          Frame(child: SalaryYearMonthWidget()),
          SizedBox(height: 50),
          Frame(child: IncreaseRateTabWidget()),
          SizedBox(height: 40),
          Divider(thickness: 7, color: Color(0xFFF2F2F2)),
          SizedBox(height: 50),
          Frame(child: CurrentValueWidget()),
          SizedBox(height: 50),
          Divider(thickness: 7, color: Color(0xFFF2F2F2)),
          SizedBox(height: 50),
          Frame(child: TenYearChartWidget()),
          SizedBox(height: 50),
          Divider(thickness: 7, color: Color(0xFFF2F2F2)),
          SizedBox(height: 50),
          Frame(child: BestPriceWidget()),
          SizedBox(height: 50),
          Divider(thickness: 7, color: Color(0xFFF2F2F2)),
          SizedBox(height: 50),
          Frame(child: AtThisTimeWidget()),
          SizedBox(height: 50),
          Divider(thickness: 7, color: Color(0xFFF2F2F2)),
          SizedBox(height: 50),
          Frame(child: ShouldBoughtThisWidget()),
          SizedBox(height: 50),
          Divider(thickness: 7, color: Color(0xFFF2F2F2)),
          SizedBox(height: 50),
          Frame(child: BuyOrNotWidget()),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget CalculatorResultWidget() {
    return Stack(
      children: <Widget>[
        CustomPaint(
          painter: MyPainter(topColor),
          size: Size(516, 316),
        ),
        Container(
          padding: EdgeInsets.only(top: 180),
          alignment: Alignment.center,
          child: Image(
            image: chickImage,
          ),
        ),
        Column(
          children: [
            SizedBox(height: 10),
            CalculatorResultAppBar(),
            SizedBox(height: 2),
            Container(
              height: 175,
              child: Column(
                children: [
                  MainTopText(textColor: textColor),
                  MainMidText(
                    textColor: textColor,
                  ),
                  MainBottomText(textColor: textColor),
                ],
              ),
            ),
            ResultCardWidget(),
          ],
        ),
      ],
    );
  }

  Widget ResultCardWidget() {
    return Container(
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
          child: Consumer<CalculatorProvider>(
              builder: (context, calculatorProvider, child) {
            CalculatorStock calculationResult =
                calculatorProvider.calculationResult;
            return Column(
              children: <Widget>[
                EmojiYieldPriceText(calculationResult),
                YieldPercentText(calculationResult),
                SizedBox(height: 8),
                Text(
                  '${calculationResult.oldCloseDate} 종가 기준',
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
                      AutoSizeText(
                        '1주당 ${numberWithComma(calculationResult.oldPrice)}원',
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
                        '${calculationResult.holdingStock.toStringAsFixed(1)}주 보유',
                        style: kOldStockTextStyle,
                        minFontSize: 15,
                        maxLines: 1,
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget CalculatorResultAppBar() {
    return Container(
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
            child: isLoading
                ? LoadingRandomWidget()
                : RandomWidget(onTap: () {
                    randomValues();
                  }),
          ),
        ],
      ),
    );
  }
}

class YieldPercentText extends StatelessWidget {
  final CalculatorStock calculationResult;
  YieldPercentText(this.calculationResult);
  @override
  Widget build(BuildContext context) {
    final yieldPercent = calculationResult.yieldPercent;
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
            text: '($yieldPercent%)',
          ),
        ],
      ),
    );
  }
}

class EmojiYieldPriceText extends StatelessWidget {
  final CalculatorStock calculationResult;
  EmojiYieldPriceText(this.calculationResult);

  @override
  Widget build(BuildContext context) {
    final yieldPercent = calculationResult.yieldPercent;
    final yieldPrice = numberWithComma(calculationResult.yieldPrice ?? '0');
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
          yieldPercent > 0
              ? TextSpan(text: '+ ')
              : yieldPercent == 0
                  ? TextSpan(text: '')
                  : TextSpan(text: '- '),
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
    canvas.drawCircle(
        Offset(size.width * 0.5, size.height * 0.2), size.height * 1, paint);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
