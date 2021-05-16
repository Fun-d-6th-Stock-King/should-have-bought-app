import 'package:flutter/material.dart';
import 'package:should_have_bought_app/api/buy_or_not/buy_or_not_api.dart';
import 'package:should_have_bought_app/models/buy_or_not/buy_or_not_chart.dart';
import 'package:should_have_bought_app/models/buy_or_not/buy_or_not_stock.dart';
import 'package:should_have_bought_app/models/buy_or_not/stock_hist.dart';
import 'package:should_have_bought_app/models/drip_room/evaluation_item.dart';

class BuyOrNotProvider with ChangeNotifier {
  BuyOrNotStock _buyOrNotStock = BuyOrNotStock();
  StockHist _stockHist = StockHist();
  EvaluationItem _evaluationItem = EvaluationItem();
  
  BuyOrNotStock get buyOrNotStock => _buyOrNotStock;
  StockHist get stockHist => _stockHist;
  EvaluationItem get evaluationItem => _evaluationItem;
  
  Future getBuyOrNotStock(String stockCode) async {
    final result = await BuyOrNotApi.getBuyOrNotStock(stockCode);
    _buyOrNotStock = BuyOrNotStock.fromJson(result);

    notifyListeners();
    //return addEvaluationItemList;
  }

  Future getBuyOrNotStockChart(String stockCode) async {
    final result = await BuyOrNotApi.getBuyOrNotStockChart(stockCode);
    print(result);
     _evaluationItem = EvaluationItem.fromJson(result['evaluation']);
     _stockHist = StockHist.fromJson(result['stockHist']);
    notifyListeners();
  }
}