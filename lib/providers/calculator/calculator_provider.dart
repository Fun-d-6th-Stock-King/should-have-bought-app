import 'package:flutter/material.dart';
import 'package:should_have_bought_app/api/calculator/calculator_api.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';

class CalculatorProvider with ChangeNotifier {
  List _companyList = [];
  List _searchCompanyList = [];

  List get companyList {
    return _companyList;
  }
  List get searchCompanyList {
    return _searchCompanyList;
  }

  void filterSearchResults(String query) {
    List<Company> dummySearchList = [];
    dummySearchList.addAll(_companyList?.cast<Company>());
    print('dummySearchList:');
    if(query.isNotEmpty) {
      List<Company> dummyListData = [];
      dummyListData = dummySearchList.where((item) {
       return item.company.contains(query);
      }).toList();

      _searchCompanyList.clear();
      _searchCompanyList.addAll(dummyListData);
      print(dummyListData);
      notifyListeners();
      return;
    } else {
      _searchCompanyList.clear();
      _searchCompanyList.addAll(_companyList);
      notifyListeners();
    }
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
    _searchCompanyList = [..._companyList];

    print(_companyList[1].code);
    notifyListeners();
  }
}