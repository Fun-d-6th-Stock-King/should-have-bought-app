import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/calculator/calculator_stock.dart';
import 'package:should_have_bought_app/utils.dart';

class ResultCardWidget extends StatelessWidget {
  final CalculatorStock calculationResult;

  const ResultCardWidget({this.calculationResult});

  @override
  Widget build(BuildContext context) {
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
          child: Column(
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
          ),
        ),
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
