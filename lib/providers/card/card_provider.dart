import 'package:flutter/material.dart';
import 'package:should_have_bought_app/api/buy_or_not/buy_or_not_api.dart';
import 'package:should_have_bought_app/api/drip_room/drip_room_api.dart';
import 'package:should_have_bought_app/models/buy_or_not/stock_hist.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';
import 'package:should_have_bought_app/models/drip_room/evaluation_item.dart';

class CardProvider with ChangeNotifier {
  List<Company> _toDoEvalList = [];
  List<StockHist> _test = [];

  List<Company> get toDoEvalList => _toDoEvalList;
  List<StockHist> get test => _test;

  Future<List> getToDoEvalList() async {
    final result = await DripRoomApi.noEvalList();

    print(result['companyList']);
    List<Company> toDoCompanyList = result['companyList'].map<Company>((item)=> Company.fromJson(item)).toList();
    _toDoEvalList = toDoCompanyList;
    for(int i = 0; i <2; i++) {
      final getChart = await BuyOrNotApi.getBuyOrNotStockChart(
          toDoCompanyList[i].code)
          .then((stockHist) {
        return StockHist.fromJson(stockHist['stockHist']);
      });
      print(getChart);
      _test = [..._test, getChart];
    }

    notifyListeners();

    return toDoCompanyList;
    }
}