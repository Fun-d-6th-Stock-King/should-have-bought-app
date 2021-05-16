import 'package:flutter/material.dart';

class BuyOrNotStock {
  final String code;
  final int buyCount;
  final int sellCount;
  final String userBuySell;

  BuyOrNotStock({@required this.code, @required this.buyCount, @required this.sellCount, @required this.userBuySell});

  factory BuyOrNotStock.fromJson(dynamic json) {
    return BuyOrNotStock(
        code: json['code'],
        buyCount: json['buyCount'],
        sellCount: json['sellCount'],
        userBuySell: json['userBuySell'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'buyCount': buyCount,
      'sellCount': sellCount,
      'userBuySell': userBuySell,
    };
  }
}
