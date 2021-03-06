import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/buy_or_not/stock_hist.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';
import 'package:should_have_bought_app/providers/buy_or_not/buy_or_not_provider.dart';
import 'package:should_have_bought_app/screens/util/loading_screen.dart';
import 'package:should_have_bought_app/screens/util/skeleton_widget.dart';
import 'package:should_have_bought_app/utils.dart';
import 'package:should_have_bought_app/models/calculator/calculator_stock.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';
import 'package:should_have_bought_app/widgets/buy_or_not/buy_or_not_select_widget.dart';
import 'package:should_have_bought_app/widgets/chart/buy_or_not_chart_widget.dart';

class TenYearChartWidget extends StatefulWidget {
  @override
  _TenYearChartWidgetState createState() => _TenYearChartWidgetState();
}

class _TenYearChartWidgetState extends State<TenYearChartWidget> {
  @override
  void didChangeDependencies() async {
    final code = Provider.of<CalculatorProvider>(context, listen: false)
        .latestDto['code'];
    await Provider.of<BuyOrNotProvider>(context, listen: false)
        .setChartLoading(true);
    await Provider.of<BuyOrNotProvider>(context, listen: false)
        .getBuyOrNotStockChart(code)
        .then((value) => Provider.of<BuyOrNotProvider>(context, listen: false)
            .setChartLoading(false));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BuyOrNotProvider>(
      builder: (context, buyOrNotProvider, child) {
        final StockHist stockHist = buyOrNotProvider.stockHist;
        final bool isLoading = buyOrNotProvider.isLoadingChart;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: isLoading
                  ? skeletonText(90, 15)
                  : Text(
                      '10?????? ${stockHist.company}????',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: isLoading
                            ? LoadingScreen()
                            : BuyOrNotChartWidget(stockHist.code),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(29),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isLoading
                              ? skeletonText(90, 15)
                              : Text(
                                  '${stockHist.lastTradeTime ?? ''}',
                                  style: dateStyle,
                                ),
                          isLoading
                              ? skeletonText(90, 20)
                              : Text(stockHist.company ?? '',
                                  style: stockTitleStyle),
                          isLoading
                              ? skeletonText(90, 30)
                              : Text(
                                  '${numberWithComma(stockHist.price?.toString() ?? '0')}???',
                                  style: stockTitleStyle),
                          isLoading
                              ? skeletonText(100, 20)
                              : Row(
                                  children: [
                                    Text(
                                      "${checkIncreaseOrDecrease(stockHist.changeInPercent)}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        height: 16 / 14,
                                        color: colorIncreaseOrDecrease(
                                            stockHist.changeInPercent),
                                      ),
                                    ),
                                    Text(
                                      "${numberWithComma(stockHist.change?.toString() ?? '0')} (${stockHist.changeInPercent?.toString() ?? '-'}%)",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        height: 16 / 14,
                                        color: colorIncreaseOrDecrease(
                                            stockHist.changeInPercent),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text('?????? 10??????', style: stockBodyStyle),
                            Text(
                              ' ?????????',
                              style: TextStyle(
                                fontSize: 14,
                                height: 20 / 14,
                                color: likeColor,
                              ),
                            )
                          ],
                        ),
                        isLoading
                            ? skeletonText(90, 25)
                            : Text(
                                '${numberWithComma(stockHist.maxQuote?.high?.toString() ?? '0')}???',
                                style: stockBodyNumberStyle),
                        isLoading
                            ? skeletonText(110, 15)
                            : Text(
                                '${commonDayDateFormat(stockHist.maxQuote?.date ?? '')} ?????? ??????',
                                style: stockDateStyle),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text('?????? 10??????', style: stockBodyStyle),
                            Text(
                              ' ?????????',
                              style: TextStyle(
                                fontSize: 14,
                                height: 20 / 14,
                                color: unlikeColor,
                              ),
                            )
                          ],
                        ),
                        isLoading
                            ? skeletonText(90, 25)
                            : Text(
                                '${numberWithComma(stockHist.minQuote?.low?.toString() ?? '0')}???',
                                style: stockBodyNumberStyle),
                        isLoading
                            ? skeletonText(110, 15)
                            : Text(
                                '${commonDayDateFormat(stockHist.minQuote?.date ?? '')} ?????? ??????',
                                style: stockDateStyle),
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
