import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/models/calculator/calculator_dto.dart';
import 'package:should_have_bought_app/models/calculator/calculator_stock.dart';
import 'package:should_have_bought_app/providers/buy_or_not/buy_or_not_provider.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';
import 'package:should_have_bought_app/utils.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/widgets/calculator/result/at_this_time_item.dart';
import 'package:should_have_bought_app/widgets/calculator/result/at_this_time_widget.dart';
import 'package:should_have_bought_app/widgets/calculator/result/best_price_widget.dart';
import 'package:should_have_bought_app/widgets/calculator/result/buy_or_not_widget.dart';
import 'package:should_have_bought_app/widgets/calculator/result/calculator_result_widget.dart';
import 'package:should_have_bought_app/widgets/calculator/result/current_value_widget.dart';
import 'package:should_have_bought_app/widgets/calculator/result/salary_year_month_widget.dart';
import 'package:should_have_bought_app/widgets/calculator/result/any_past_year_widget.dart';
import 'package:should_have_bought_app/widgets/calculator/result/increase_rate_tab_widget.dart';
import 'package:should_have_bought_app/widgets/calculator/result/should_bought_this_widget.dart';
import 'package:should_have_bought_app/widgets/calculator/result/ten_year_invest_chart_widget.dart';

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
    super.initState();
  }

  @override
  void didChangeDependencies() {
    reBuildApi();
    setDynamicOption();
    super.didChangeDependencies();
  }

  void reBuildApi() async {
    final code = Provider.of<CalculatorProvider>(context, listen: false)
        .latestDto['code'];
    await Provider.of<CalculatorProvider>(context, listen: false)
        .getSectorData();
    await Provider.of<CalculatorProvider>(context, listen: false)
        .getTenYearHigher();
    await Provider.of<BuyOrNotProvider>(context, listen: false)
        .setChartLoading(true);
    await Provider.of<BuyOrNotProvider>(context, listen: false)
        .getBuyOrNotStockChart(code)
        .then((value) => Provider.of<BuyOrNotProvider>(context, listen: false)
            .setChartLoading(false));
    await Provider.of<CalculatorProvider>(context, listen: false)
        .getBestPrice();
    await Provider.of<CalculatorProvider>(context, listen: false)
        .getFourResult();
    await Provider.of<CalculatorProvider>(context, listen: false)
        .getPeriodBestPrice();
    await Provider.of<BuyOrNotProvider>(context, listen: false)
        .getBuyOrNotStock(code);
    await Provider.of<BuyOrNotProvider>(context, listen: false)
        .getBestEvaluateList(1, 1, 'MONTH12', code);
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Frame(
            child: CalculatorResultWidget(
              topColor: topColor,
              textColor: textColor,
              chickImage: chickImage,
              isLoading: isLoading,
              onTap: () async {
                randomValues();
              },
            ),
          ),
          SizedBox(height: 50),
          Frame(child: SalaryYearMonthWidget()),
          SizedBox(height: 20),
          Frame(child: AnyPastYearWidget()),
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
}
