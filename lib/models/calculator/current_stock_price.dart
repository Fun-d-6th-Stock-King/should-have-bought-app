
class CurrentStockPrice {
  final String code;
  final String company;
  final double changeInPercent;
  final double price;
  final double dayHigh;
  final double dayLow;
  final double weekHigh;
  final double weekLow;
  final double yearHigh;
  final double yearLow;

  CurrentStockPrice({this.code='', this.company='', this.changeInPercent=0, this.price=0, this.dayHigh=0, this.dayLow=0, this.weekHigh=0, this.weekLow=0,this.yearHigh=0, this.yearLow=0});

  factory CurrentStockPrice.fromJson(dynamic json) {
    return CurrentStockPrice(
        code: json['code'],
        company: json['company'],
        changeInPercent: json['changeInPercent'],
        price: json['price'],
        dayHigh: json['dayHigh'],
        dayLow: json['dayLow'],
        weekHigh: json['weekHigh'],
        weekLow: json['weekLow'],
        yearHigh: json['yearHigh'],
        yearLow: json['yearLow']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'company': company,
      'changeInPercent': changeInPercent,
      'price': price,
      'dayHigh':dayHigh,
      'dayLow': dayLow,
      'weekHigh': weekHigh,
      'weekLow': weekLow,
      'yearHigh': yearHigh,
      'yearLow': yearLow,
    };
  }
}