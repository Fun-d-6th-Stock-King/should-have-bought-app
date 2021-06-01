import 'package:should_have_bought_app/models/calculator/result/calculator_date_stock.dart';

class CalculatorStockAll {
  String code;
  String name;
  final Map<String, CalculatorDateStock> dateToStock = {};

  CalculatorStockAll.fromJson(Map<dynamic, dynamic> map) {
    code = map['code'];
    name = map['company'];
    dateToStock['day1'] = toStock(map['day1']);
    dateToStock['week1'] = toStock(map['week1']);
    dateToStock['month1'] = toStock(map['month1']);
    dateToStock['month6'] = toStock(map['month6']);
    dateToStock['year1'] = toStock(map['year1']);
    dateToStock['year10'] = toStock(map['year10']);
  }

  CalculatorDateStock toStock(Map<dynamic, dynamic> map) {
    if (map == null) return null;
    return CalculatorDateStock(
      investDate: map['investDate'],
      investPrice: map['investPrice'].toString(),
      yieldPrice: map['yieldPrice'].toString(),
      yieldPercent: map['yieldPercent'].toInt(),
      oldCloseDate: map['oldCloseDate'],
      oldPrice: map['oldPrice'].toString(),
      holdingStock: map['holdingStock'].toDouble(),
    );
  }
}
