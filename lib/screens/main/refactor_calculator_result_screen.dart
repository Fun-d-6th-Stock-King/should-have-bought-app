import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/models/calculator/calculator_dto.dart';
import 'package:should_have_bought_app/models/calculator/calculator_stock.dart';
import 'package:should_have_bought_app/providers/buy_or_not/buy_or_not_provider.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';
import 'package:should_have_bought_app/utils.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/widgets/calculator/result/calculator_result_widget.dart';
import 'package:should_have_bought_app/widgets/calculator/result/salary_year_month_widget.dart';

class RefactorCalculatorResultScreen extends StatefulWidget {
  static const routeId = '/refactor-result';
  @override
  _RefactorCalculatorResultScreenState createState() =>
      _RefactorCalculatorResultScreenState();
}

class _RefactorCalculatorResultScreenState
    extends State<RefactorCalculatorResultScreen> {
  bool isLoading = false;
  bool isBottomSheet = false;
  Color textColor;
  Color topColor;
  AssetImage chickImage;
  CalculatorStock calculatorResult;

  @override
  void initState() {
    reBuildApi();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setDynamicOption();
    super.didChangeDependencies();
  }

  void reBuildApi() {
    Provider.of<CalculatorProvider>(context, listen: false).getSectorData();
    Provider.of<CalculatorProvider>(context, listen: false).getTenYearHigher();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<CalculatorProvider, BuyOrNotProvider>(
        builder: (context, calcualtorProvider, buyornotProvider, child) {
          final calculationResult = calcualtorProvider.calculationResult;
          return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    floating: true,
                    backgroundColor: topColor,
                  )
                ];
              },
              body: ListView(
                children: <Widget>[
                  Frame(
                    child: CalculatorResultWidget(
                      topColor: topColor,
                      textColor: textColor,
                      chickImage: chickImage,
                      calculationResult: calculationResult,
                    ),
                  ),
                  SizedBox(height: 50),
                  Frame(
                      child: SalaryYearMonthWidget(
                    calculationResult: calculationResult,
                  )),
                ],
              ));
        },
      ),
    );
  }
}
