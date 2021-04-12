class CalculatorStock {
  String code;
  String name;
  int currentPrice;
  DateTime lastTradingDateTime;
  Map<String, dynamic> calculationResult;

  CalculatorStock.fromMap(Map<String, dynamic> map) {
    code = map['code'];
    name = map['company'];
    currentPrice = map['currentPrice'];
    // lastTradingDateTime = DateTime.parse(map['lastTrandingDateTime']);
    calculationResult = map['calculationResult'];
  }
}
