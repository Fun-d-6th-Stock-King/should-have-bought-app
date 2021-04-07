class CalculatorStock {
  String name;
  String investDate;
  int investPrice;
  double yieldPrice;
  double yieldPercent;
  int oldPrice;

  CalculatorStock.fromMap(Map<String, dynamic> map) {
    name = map['company'];
    investDate = map['calculationResult']['investDate'];
    investPrice = map['calculationResult']['investPrice'];
    yieldPrice = map['calculationResult']['yieldPrice'];
    yieldPercent = map['calculationResult']['yieldPercent'];
    oldPrice = map['calculationResult']['oldPrice'];
  }
}
