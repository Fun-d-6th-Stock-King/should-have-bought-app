import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/buy_or_not/stock_hist.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';
import 'package:should_have_bought_app/models/drip_room/evaluation_item.dart';
import 'package:should_have_bought_app/providers/buy_or_not/buy_or_not_provider.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_widget_provider.dart';
import 'package:should_have_bought_app/screens.dart';
import 'package:should_have_bought_app/screens/tab_screen.dart';
import 'package:should_have_bought_app/screens/util/skeleton_widget.dart';
import 'package:should_have_bought_app/utils.dart';
import 'package:should_have_bought_app/widgets/chart/buy_or_not_chart_widget.dart';

class HowToBoughtThenWidget extends StatefulWidget {
  final Company company;

  HowToBoughtThenWidget(this.company);
  @override
  _CreateHowToBoughtThenWidgetState createState() => _CreateHowToBoughtThenWidgetState();
}

class _CreateHowToBoughtThenWidgetState extends State<HowToBoughtThenWidget> {
  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();
    Provider.of<BuyOrNotProvider>(context, listen: false).setChartLoading(true);
    await Provider.of<BuyOrNotProvider>(context, listen:false)
        .getBuyOrNotStockChart(widget.company.code).then((value) => Provider.of<BuyOrNotProvider>(context, listen: false).setChartLoading(false));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
      ),
      child: Consumer<BuyOrNotProvider>(
          builder: (context, buyOrNotProvider, child) {
            final StockHist stockHist = buyOrNotProvider.stockHist;
            final bool isLoading = buyOrNotProvider.isLoadingChart;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: isLoading ? LoadingScreen() : BuyOrNotChartWidget(widget.company.code)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(29),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isLoading ? skeletonText(90, 15) :
                          Text(
                            '${stockHist.lastTradeTime ?? ''}',
                            style: dateStyle,
                          ),
                          isLoading ? skeletonText(90, 20) :
                          Text(widget.company.company ?? '',
                              style: stockTitleStyle),
                          isLoading ? skeletonText(90, 30) :
                          Text(
                              '${numberWithComma(stockHist.price?.toString() ?? '0')}원',
                              style: stockTitleStyle),
                          isLoading ? skeletonText(100, 20) :
                          Row(
                            children: [
                              Text(
                                  "${checkIncreaseOrDecrease(stockHist.changeInPercent)}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      height: 16 / 14,
                                      color: colorIncreaseOrDecrease(stockHist.changeInPercent))),
                              Text(
                                  "${numberWithComma(stockHist.change?.toString() ?? '0')} (${stockHist.changeInPercent?.toString() ?? '-'}%)",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      height: 16 / 14,
                                      color: colorIncreaseOrDecrease(stockHist.changeInPercent))),
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
                            Text('최근 10년간', style: stockBodyStyle),
                            Text(
                              ' 최고가',
                              style: TextStyle(
                                fontSize: 14,
                                height: 20 / 14,
                                color: likeColor,
                              ),
                            )
                          ],
                        ),
                        isLoading ? skeletonText(90, 25) :
                        Text(
                            '${numberWithComma(stockHist.maxQuote?.high?.toString() ?? '0')}원',
                            style: stockBodyNumberStyle),
                        isLoading ? skeletonText(110, 15) :
                        Text(
                            '${commonDayDateFormat(stockHist.maxQuote?.date ?? '')} 종가 기준',
                            style: stockDateStyle),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text('최근 10년간', style: stockBodyStyle),
                            Text(
                              ' 최저가',
                              style: TextStyle(
                                fontSize: 14,
                                height: 20 / 14,
                                color: unlikeColor,
                              ),
                            )
                          ],
                        ),
                        isLoading ? skeletonText(90, 25) :
                        Text(
                            '${numberWithComma(stockHist.minQuote?.low?.toString() ?? '0')}원',
                            style: stockBodyNumberStyle),
                        isLoading ? skeletonText(110, 15) :
                        Text(
                            '${commonDayDateFormat(stockHist.minQuote?.date ?? '')} 종가 기준',
                            style: stockDateStyle),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: mainColor,
                          onPrimary: mainColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                16.0), //side: BorderSide(color: Colors.red)
                          )),
                      onPressed: () {
                        print('action');
                        isLoading ? null : actionHowToBoughtThen(context);
                      },
                      child: SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '그때 샀으면 지금 얼마게?',
                              style: TextStyle
                                (
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      )),
                )
              ],
            );
          }),
    );
  }
  void actionHowToBoughtThen(BuildContext context) {
    Provider.of<CalculatorWidgetProvider>(context, listen: false)
        .setCompanyAndDateValue(Company(company: widget.company.company, code: widget.company.code), 'YEAR10');
    Navigator.pop(context);
    Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => TabScreen(selectIndex: 0)));
  }
}

