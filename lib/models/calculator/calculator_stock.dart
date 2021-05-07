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
  }
}
