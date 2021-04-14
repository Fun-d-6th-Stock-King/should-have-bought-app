import 'package:flutter/material.dart';
import 'package:should_have_bought_app/api/calculator/calculator_api.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';

class CalculatorProvider with ChangeNotifier {
  List _companyList = [];

  List get companyList {
    return _companyList;
  }
  Future getResult() async {
    final result = await CalculatorApi.getResult();
    // print('[getarticles]');
    // List descSortArticles = articleList;
    // descSortArticles.sort((b, a) => a['articleId'].compareTo(b['articleId']));
    //
    // _articles = descSortArticles;
    // _allArticles = descSortArticles;
    //notifyListeners();
  }
  Future getCompanies() async {
    final result = await CalculatorApi.getCompanies();
    print(result['companyList']);
    List list = result['companyList'];

    _companyList = list.map((company) =>
        Company(company['company'],company['code'])
    ).toList();
    print(_companyList[1].code);
    notifyListeners();
  }
}