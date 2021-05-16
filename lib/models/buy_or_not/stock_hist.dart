import 'package:flutter/cupertino.dart';
import 'package:should_have_bought_app/models/buy_or_not/buy_or_not_chart.dart';

class StockHist {
  final String code;
  final double price;
  final double changeInPercent;
  final BuyOrNotChart maxQuote;
  final BuyOrNotChart minQuote;
  final List<BuyOrNotChart> quoteList;

  StockHist({@required this.code, @required this.price, @required this.changeInPercent, @required this.maxQuote, @required this.minQuote, @required this.quoteList});

  factory StockHist.fromJson(dynamic json) {
    return StockHist(
      code: json['code'],
      price: json['price'] ?? 0,
      changeInPercent: json['changeInPercent'],
      maxQuote: BuyOrNotChart.fromJson(json['maxQuote']),
      minQuote: BuyOrNotChart.fromJson(json['minQuote']),
      quoteList: json['quoteList'].map<BuyOrNotChart>((value)=> BuyOrNotChart.fromJson(value)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'price': price,
      'changeInPercent': changeInPercent,
      'maxQuote': maxQuote,
      'minQuote': minQuote,
      'quoteList': quoteList,
    };
  }
}