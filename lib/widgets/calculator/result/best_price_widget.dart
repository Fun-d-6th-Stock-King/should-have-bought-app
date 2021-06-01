import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';
import 'package:should_have_bought_app/utils.dart';

class BestPriceWidget extends StatefulWidget {
  @override
  _BestPriceWidgetState createState() => _BestPriceWidgetState();
}

class _BestPriceWidgetState extends State<BestPriceWidget> {
  @override
  void didChangeDependencies() async {
    await Provider.of<CalculatorProvider>(context, listen: false)
        .getBestPrice();
    super.didChangeDependencies();
  }

  Color yieldColor;
  void setYieldTextColor(int yieldPercent) {
    if (yieldPercent > 0) {
      yieldColor = Color(0xFFFF6B76);
    } else if (yieldPercent < 0) {
      yieldColor = Color(0xFF4990FF);
    } else {
      yieldColor = Colors.black;
    }
  }

  String getYieldPercent(int percent) {
    if (percent > 0) {
      return '+ $percent%';
    } else if (percent < 0) {
      return '- $percent%';
    } else {
      return '$percent%';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
        builder: (context, calculatorProvider, child) {
      final _bestPrice = calculatorProvider.bestPriceResult;
      if (_bestPrice == null) {
        return Center(child: CircularProgressIndicator());
      }
      setYieldTextColor(_bestPrice.yieldPercent);
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '기간 내 최고가에 팔았다면?',
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
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Color(0xFFAEAEAE).withOpacity(0.16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  height: 46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                    color: Color(0xFFAEAEAE).withOpacity(0.10),
                  ),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: '${convertMoney(_bestPrice.investPrice)}원',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(text: ' 샀으면')
                          ],
                        ),
                      )),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AutoSizeText.rich(
                        TextSpan(
                          style: TextStyle(
                            fontSize: 30,
                            color: yieldColor,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  '${numberWithComma(_bestPrice.yieldPrice)}원',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                                text:
                                    '(${getYieldPercent(_bestPrice.yieldPercent)})'),
                          ],
                        ),
                        maxLines: 1,
                        minFontSize: 10,
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: <Widget>[
                          Text(
                            '보유기간',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            height: 16,
                            width: 1,
                            child: Divider(
                              thickness: 7,
                            ),
                            color: Color(0xFF8E8E8E).withOpacity(0.1),
                          ),
                          Text(
                            '${_bestPrice.investPeriod}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        '${_bestPrice.investStartDate} ~ ${_bestPrice.investEndDate}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF949597),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      );
    });
  }
}
