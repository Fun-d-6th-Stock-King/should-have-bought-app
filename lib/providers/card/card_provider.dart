import 'package:flutter/material.dart';
import 'package:should_have_bought_app/api/buy_or_not/buy_or_not_api.dart';
import 'package:should_have_bought_app/api/drip_room/drip_room_api.dart';
import 'package:should_have_bought_app/models/buy_or_not/stock_hist.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';
import 'package:should_have_bought_app/models/drip_room/evaluation_item.dart';

class CardProvider with ChangeNotifier {
  List<StockHist> _toDoEvalList = [];

  List<StockHist> get toDoEvalList => _toDoEvalList;
  Future<List> getToDoEvalList() async {
    final result = await DripRoomApi.noEvalList();
    List<Company> toDoCompanyList = result['companyList'].map<Company>((item)=> Company.fromJson(item)).toList();
    final toDoEvalList = toDoCompanyList.map((item) async{
      final getChart = await BuyOrNotApi.getBuyOrNotStockChart(item.code).then((stockHist) {
        return StockHist.fromJson(stockHist['stockHist']);
      });
      return getChart;
    }).toList();
    print(toDoEvalList);
    return toDoEvalList;
    //
    // _toDoEvalList = toDoEvalList;
    // print('cardPr');
    // print(toDoEvalList);
    // notifyListeners();
  }
}