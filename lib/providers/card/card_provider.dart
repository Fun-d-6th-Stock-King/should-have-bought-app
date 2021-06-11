import 'package:flutter/material.dart';
import 'package:should_have_bought_app/api/buy_or_not/buy_or_not_api.dart';
import 'package:should_have_bought_app/api/drip_room/drip_room_api.dart';
import 'package:should_have_bought_app/models/buy_or_not/stock_hist.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';
import 'package:should_have_bought_app/models/card/chart_dto.dart';
import 'package:should_have_bought_app/models/drip_room/evaluation_item.dart';

class CardProvider with ChangeNotifier {
  List<Company> _toDoEvalList = [];
  List<ChartDto> _cardList = [];

  List<Company> get toDoEvalList => _toDoEvalList;
  List<ChartDto> get cardList => _cardList;

  Future<List> getToDoEvalList() async {
    final result = await DripRoomApi.noEvalList();
    print(result['companyList']);
    List<Company> toDoCompanyList = result['companyList'].map<Company>((item)=> Company.fromJson(item)).toList();
    _toDoEvalList = toDoCompanyList;
    List<ChartDto> chartDtoList = [];
    for(int i = 0; i <5; i++) {
      final getChart = await BuyOrNotApi.getBuyOrNotStockChart(
          toDoCompanyList[i].code);
      chartDtoList.add(ChartDto(
        evaluation: getChart['evaluation'] == null ? EvaluationItem() : EvaluationItem.fromJson(getChart['evaluation']),
        stockHist: StockHist.fromJson(getChart['stockHist'])
      ));

    }
    _cardList = chartDtoList;
     notifyListeners();

    return chartDtoList;
    }
  Future setBuyOrNotStock(String stockCode, String buySell) async {
    Map<String, dynamic> params = {
      'buySell': buySell == 'NULL' ? null : buySell,
    };
    final result = await BuyOrNotApi.setBuyOrNotStock(stockCode, params);
    print(result);
  }
}