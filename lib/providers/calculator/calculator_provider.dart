import 'package:flutter/material.dart';
import 'package:should_have_bought_app/api/calculator/calculator_api.dart';
import 'package:should_have_bought_app/models/calculator/calculator_stock.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';

class CalculatorProvider with ChangeNotifier {
  List _companyList = [];
  List _searchCompanyList = [];
  Map<dynamic, dynamic> _lastParam;

  CalculatorStock calculationResult;

  List get companyList {
    return _companyList;
  }

  List get searchCompanyList {
    return _searchCompanyList;
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
    _lastParam = params;
    final result = await CalculatorApi.getResult(params);
    print(result);
    // ToDo: 모델 객체 만들어서 처리 필요.
    calculationResult = CalculatorStock.fromJson(result);
    notifyListeners();
  }

  Future fetchResult() async {
    final result = await CalculatorApi.getResult(_lastParam);
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
}
