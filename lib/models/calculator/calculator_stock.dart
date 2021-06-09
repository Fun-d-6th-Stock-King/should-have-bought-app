import 'package:should_have_bought_app/models/calculator/result/exception_case.dart';

class CalculatorStock {
  String code;
  String name;
  int currentPrice;
  DateTime lastTradingDateTime;
  String investDate;
  String investPrice;
  String yieldPrice;
  int yieldPercent;
  String oldCloseDate;
  String oldPrice;
  double holdingStock;
  String salaryYear;
  String salaryMonth;
  Map topStocks = {
    '삼성전자': 0.0,
    'SK하이닉스': 0.0,
    '카카오': 0.0,
  };
  ExceptionCase exceptionCase;

  CalculatorStock.fromJson(Map<dynamic, dynamic> map) {
    code = map['code'];
    name = map['company'];
    currentPrice = map['currentPrice'].toInt();
    // lastTradingDateTime = DateTime.parse(map['lastTrandingDateTime']);
    investDate = map['calculatedValue']['investDate'];
    investPrice = map['calculatedValue']['investPrice'].toString();
    yieldPrice = map['calculatedValue']['yieldPrice'].toString();
    yieldPercent = map['calculatedValue']['yieldPercent'].toInt();
    oldCloseDate = map['calculatedValue']['oldCloseDate'];
    oldPrice = map['calculatedValue']['oldPrice'].toString();
    holdingStock = map['calculatedValue']['holdingStock'].toDouble();
    salaryYear = map['calculatedValue']['salaryYear'].toString();
    salaryMonth = map['calculatedValue']['salaryMonth'].toString();
    topStocks['삼성전자'] = map['calculatedValue']['samsungStock'];
    topStocks['SK하이닉스'] = map['calculatedValue']['skStock'];
    topStocks['카카오'] = map['calculatedValue']['kakaoStock'];
    exceptionCase = ExceptionCase.fromJson(map['exceptCase']);
  }
}
