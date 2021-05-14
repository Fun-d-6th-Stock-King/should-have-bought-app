import 'package:flutter/material.dart';
import 'package:should_have_bought_app/api/buy_or_not/buy_or_not_api.dart';
import 'package:should_have_bought_app/models/buy_or_not/buy_or_not_stock.dart';

class BuyOrNotProvider with ChangeNotifier {
  BuyOrNotStock _buyOrNotStock = BuyOrNotStock();

  BuyOrNotStock get buyOrNotStock => _buyOrNotStock;

  Future getBuyOrNotStock(String stockCode) async {
    final result = await BuyOrNotApi.getBuyOrNotStock(stockCode);
    _buyOrNotStock = BuyOrNotStock.fromJson(result);

    notifyListeners();
    //return addEvaluationItemList;
  }
}