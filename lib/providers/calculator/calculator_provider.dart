import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:should_have_bought_app/api/calculator/calculator_api.dart';
import 'package:should_have_bought_app/models/calculator/calculator_dto.dart';
import 'package:should_have_bought_app/models/calculator/calculator_history.dart';
import 'package:should_have_bought_app/models/calculator/calculator_stock.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';
import 'package:should_have_bought_app/models/calculator/result/calculator_stock_all.dart';
import 'package:should_have_bought_app/models/calculator/result/sectorData.dart';

class CalculatorProvider with ChangeNotifier {
  List _companyList = [];
  List _searchCompanyList = [];
  List _tenYearHighList = [];
  List _calculateHistory = [];
  Map latestDto;
  ClaculatorStockAll calculationResultAll;
  CalculatorStock calculationResult;
  SectorData sectorData;

  List get companyList {
    return _companyList;
  }

  List get searchCompanyList {
    return _searchCompanyList;
  }

  List get tenYearHighList {
    return _tenYearHighList;
  }

  List get calculateHistory {
    return _calculateHistory;
  }

  void filterSearchResults(String query) {
    List<Company> dummySearchList = [];
    dummySearchList.addAll(_companyList?.cast<Company>());

    if (query.isNotEmpty) {
      List<Company> dummyListData = [];
      dummyListData = dummySearchList
          .where((item) => item.company.contains(query))
          .toList();

      _searchCompanyList.clear();
      _searchCompanyList.addAll(dummyListData);
      notifyListeners();
      return;
    }
    _searchCompanyList.clear();
    _searchCompanyList.addAll(_companyList);
    notifyListeners();
  }

  Future getResult(Map params) async {
    latestDto = params;
    final result = await CalculatorApi.getResult(params);
    print(result);
    // ToDo: 모델 객체 만들어서 처리 필요.
    calculationResult = CalculatorStock.fromJson(result);
    notifyListeners();
  }

  Future randomResult(Map params) async {
    latestDto = params;
    final result = await CalculatorApi.getResult(params);
    print(result);
    calculationResult = CalculatorStock.fromJson(result);
    notifyListeners();
  }

  Future getCompanies() async {
    final result = await CalculatorApi.getCompanies();
    print(result['companyList']);
    List list = result['companyList'];

    _companyList = list.map((company) => Company.fromJson(company)).toList();
    _searchCompanyList = [..._companyList];

    print(_companyList[1].code);
    notifyListeners();
  }

  Future getTenYearHigher() async {
    final result = await CalculatorApi.getTenYearHigher();
    List list = result;

    if (list != null) {
      _tenYearHighList = list
          .map((e) =>
              {"company": e["company"], "high": e["maxQuote"]["high"].toInt()})
          .toList();
      notifyListeners();
    }
  }

  Future getHistory({int pageNo = 1, int pageSize = 10}) async {
    var list = [];
    final result = await CalculatorApi.getHistoryList(pageNo, pageSize);
    list = result['calculationHistList'];
    if (list != null) {
      _calculateHistory =
          list.map((history) => CalculatorHistory.fromJson(history)).toList();
      notifyListeners();
    }
  }

  Future getSectorData() async {
    final result = await CalculatorApi.getSectorInfor(latestDto['code'],
        latestDto['investDate'], int.parse(latestDto['investPrice']));
    sectorData = SectorData.fromJson(result);
    notifyListeners();
  }

  Future getFourResult() async {
    final result = await CalculatorApi.getAllResult(
        latestDto['code'], int.parse(latestDto['investPrice']));
    calculationResultAll = ClaculatorStockAll.fromJson(result);
    print(calculationResultAll);
    notifyListeners();
  }
}
