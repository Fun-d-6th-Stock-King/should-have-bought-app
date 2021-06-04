import 'package:flutter/material.dart';
import 'package:should_have_bought_app/api/buy_or_not/buy_or_not_api.dart';
import 'package:should_have_bought_app/models/buy_or_not/buy_or_not_chart.dart';
import 'package:should_have_bought_app/models/buy_or_not/buy_or_not_stock.dart';
import 'package:should_have_bought_app/models/buy_or_not/stock_hist.dart';
import 'package:should_have_bought_app/models/buy_or_not/top_rank.dart';
import 'package:should_have_bought_app/models/buy_or_not/top_rank_evaluation.dart';
import 'package:should_have_bought_app/models/drip_room/evaluation_item.dart';
import 'package:should_have_bought_app/models/buy_or_not/stock_evaluation_list.dart';
import 'package:should_have_bought_app/models/buy_or_not/stock_evaluation_item.dart';

class BuyOrNotProvider with ChangeNotifier {
  BuyOrNotStock _buyOrNotStock = BuyOrNotStock();
  StockHist _stockHist = StockHist();
  EvaluationItem _evaluationItem = EvaluationItem();
  StockEvaluationList _stockEvaluationList = StockEvaluationList();
  TopRank _topRank =
      TopRank(topRankEvaluation: TopRankEvaluation(), topRankList: []);
  bool _isLoadingBuyOrNot = false;
  bool _isLoadingChart = false;

  BuyOrNotStock get buyOrNotStock => _buyOrNotStock;
  StockHist get stockHist => _stockHist;
  EvaluationItem get evaluationItem => _evaluationItem;
  StockEvaluationList get stockEvaluationList => _stockEvaluationList;
  TopRank get topRank => _topRank;
  bool get isLoadingBuyOrNot => _isLoadingBuyOrNot;
  bool get isLoadingChart => _isLoadingChart;

  Future getBuyOrNotStock(String stockCode) async {
    final result = await BuyOrNotApi.getBuyOrNotStock(stockCode);
    _buyOrNotStock = BuyOrNotStock.fromJson(result);

    notifyListeners();
    //return addEvaluationItemList;
  }

  Future getBuyOrNotStockChart(String stockCode) async {
    final result = await BuyOrNotApi.getBuyOrNotStockChart(stockCode);
    print(result);
    final responseEvaluation = result['evaluation'] ?? EvaluationItem().toMap();
    _evaluationItem = EvaluationItem.fromJson(responseEvaluation);
    _stockHist = StockHist.fromJson(result['stockHist']);
    notifyListeners();
  }

  Future setBuyOrNotStock(String stockCode, String buySell) async {
    Map<String, dynamic> params = {
      'buySell': buySell == 'NULL' ? null : buySell,
    };
    _buyOrNotStock = BuyOrNotStock.fromJson(_buyOrNotStock.toMap()
      ..addAll({'userBuySell': buySell})
      ..addAll({
        'buyCount': buySell == 'BUY'
            ? _buyOrNotStock.buyCount + 1
            : _buyOrNotStock.userBuySell == 'BUY'
                ? _buyOrNotStock.buyCount - 1
                : _buyOrNotStock.buyCount
      })
      ..addAll({
        'sellCount': buySell == 'SELL'
            ? _buyOrNotStock.sellCount + 1
            : _buyOrNotStock.userBuySell == 'SELL'
                ? _buyOrNotStock.sellCount - 1
                : _buyOrNotStock.sellCount
      }));
    notifyListeners();
    final result = await BuyOrNotApi.setBuyOrNotStock(stockCode, params);
    print(result);
  }

  void setBuyOrNotLoading(bool isLoading) {
    _isLoadingBuyOrNot = isLoading;
  }

  void setChartLoading(bool isLoading) {
    _isLoadingChart = isLoading;
  }

  Future getBuyRankList(String buySell, String rankListType) async {
    final result = await BuyOrNotApi.getBuyRankList(buySell, rankListType);
    print(result);
    _topRank = TopRank.fromJson(result);
    notifyListeners();
  }

  Future getBestEvaluateList(
      int pageNo, int pageSize, String period, String code) async {
    final result =
        await BuyOrNotApi.getBestEvaluateList(pageNo, pageSize, period, code);
    final list = result['evaluationList'];
    _stockEvaluationList.evaluationList = list
        .map<StockEvaluationItem>((item) => StockEvaluationItem.fromJson(item))
        .toList();
    _stockEvaluationList.pageInfo = result['pageInfo'];
    notifyListeners();
  }
}
