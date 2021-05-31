import 'package:should_have_bought_app/utils.dart';

class BestPrice {
  String code;
  String investDate;
  String investPrice;
  String yieldPrice;
  int yieldPercent;
  String investStartDate;
  String investEndDate;
  String investPeriod;

  BestPrice.fromJson(Map<dynamic, dynamic> map) {
    code = map['code'];
    investDate = map['investDate'];
    investPrice = map['investPrice'].toString();
    yieldPrice = map['yieldPrice'].toStringAsFixed(0);
    yieldPercent = map['yieldPercent'].toInt();
    investStartDate = commonTwoDayDateFormat(map['investStartDate']);
    investEndDate = commonTwoDayDateFormat(map['investEndDate']);
    investPeriod = map['investPeriod'];
  }
}
