import 'package:flutter/cupertino.dart';

class CalculatorDateStock {
  String investDate;
  String investPrice;
  String yieldPrice;
  int yieldPercent;
  String oldCloseDate;
  String oldPrice;
  double holdingStock;

  CalculatorDateStock({
    @required this.investDate,
    @required this.investPrice,
    @required this.yieldPrice,
    @required this.yieldPercent,
    @required this.oldCloseDate,
    @required this.oldPrice,
    @required this.holdingStock,
  });
}
