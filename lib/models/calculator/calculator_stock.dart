class CalculatorStock {
  String code;
  String name;
  int currentPrice;
  DateTime lastTradingDateTime;
  String investDate;
  int investPrice;
  int yieldPrice;
  int yieldPercent;
  String oldCloseDate;
  int oldPrice;
  double holdingStock;
  int salaryYear;
  int salaryMonth;

  CalculatorStock.fromJson(Map<dynamic, dynamic> map) {
    code = map['code'];
    name = map['company'];
    currentPrice = map['currentPrice'].toInt();
    // lastTradingDateTime = DateTime.parse(map['lastTrandingDateTime']);
    investDate = map['calculatedValue']['investDate'];
    investPrice = map['calculatedValue']['investPrice'];
    yieldPrice = map['calculatedValue']['yieldPrice'].toInt();
    yieldPercent = map['calculatedValue']['yieldPercent'].toInt();
    oldCloseDate = map['calculatedValue']['oldCloseDate'];
    oldPrice = map['calculatedValue']['oldPrice'];
    holdingStock = map['calculatedValue']['holdingStock'];
    salaryYear = map['calculatedValue']['salaryYear'].toInt();
    salaryMonth = map['calculatedValue']['salaryMonth'].toInt();
  }
}
