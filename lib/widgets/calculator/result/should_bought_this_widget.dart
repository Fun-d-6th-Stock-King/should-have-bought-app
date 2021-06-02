import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';
import 'package:should_have_bought_app/utils.dart';

class ShouldBoughtThisWidget extends StatefulWidget {
  @override
  _ShouldBoughtThisWidgetState createState() => _ShouldBoughtThisWidgetState();
}

class _ShouldBoughtThisWidgetState extends State<ShouldBoughtThisWidget> {
  @override
  void didChangeDependencies() async {
    await Provider.of<CalculatorProvider>(context, listen: false)
        .getPeriodBestPrice();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
        builder: (context, calculatorProvider, child) {
      final _periodList = calculatorProvider.periodBestPriceList;
      return _periodList == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '검색 기간동안 가장 많이 오른 종목',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF828282),
                        ),
                      ),
                      Text(
                        '이것도 살걸',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 130,
                  child: ListView.builder(
                    itemCount: _periodList.length ?? 0,
                    itemBuilder: (context, index) {
                      return StockTile(
                        index: index,
                        company: _periodList[index].company,
                        price: _periodList[index].price,
                        percent: _periodList[index].yieldPercent,
                      );
                    },
                  ),
                )
              ],
            );
    });
  }
}

class StockTile extends StatelessWidget {
  final int index;
  final String company;
  final String price;
  final double percent;
  const StockTile({this.index, this.company, this.price, this.percent});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      padding: EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 15.0),
            child: Text((index + 1).toString()),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: mediaQuery.size.width * 0.3,
              minWidth: mediaQuery.size.width * 0.3,
            ),
            child: AutoSizeText(
              company,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color(0xFF141414),
              ),
              maxLines: 1,
              minFontSize: 11,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: mediaQuery.size.width * 0.25,
              minWidth: mediaQuery.size.width * 0.25,
            ),
            child: AutoSizeText(
              '${numberWithComma(price)}원',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color(0xFF858585),
              ),
              maxLines: 1,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: mediaQuery.size.width * 0.25,
              maxWidth: mediaQuery.size.width * 0.25,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
              child: AutoSizeText(
                '${checkIncreaseOrDecrease(percent)} $percent%',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                minFontSize: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Color(0xFFFF6561).withOpacity(0.14),
              ),
            ),
          )
        ],
      ),
    );
  }
}
