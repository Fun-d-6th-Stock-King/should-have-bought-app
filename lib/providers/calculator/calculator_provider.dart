import 'package:flutter/material.dart';
import 'package:should_have_bought_app/api/calculator/calculator_api.dart';
import 'package:should_have_bought_app/models/calculator/calculator_history.dart';
import 'package:should_have_bought_app/models/calculator/calculator_stock.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';

class CalculatorProvider with ChangeNotifier {
  List _companyList = [];
  List _searchCompanyList = [];
  List _calculateHistory = [];

  CalculatorStock calculationResult;

  List get companyList {
    return _companyList;
  }

  List get searchCompanyList {
    return _searchCompanyList;
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
    final result = await CalculatorApi.getResult(params);
    print(result);
    // ToDo: 모델 객체 만들어서 처리 필요.
    calculationResult = CalculatorStock.fromJson(result);
    notifyListeners();
  }

  Future randomResult(Map params) async {
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

  Future getHistory(int pageNo, int pageSize) async {
    final result = await CalculatorApi.getHistoryList(pageNo, pageSize);
    List list = result['calculationHistList'];

    _calculateHistory =
        list.map((history) => CalculatorHistory.fromJson(history)).toList();
    notifyListeners();
  }
}
