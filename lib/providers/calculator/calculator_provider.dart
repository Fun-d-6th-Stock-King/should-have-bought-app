import 'package:flutter/material.dart';
import 'package:should_have_bought_app/api/calculator/calculator_api.dart';
import 'package:should_have_bought_app/models/calculator/calculator_history.dart';
import 'package:should_have_bought_app/models/calculator/calculator_stock.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';
import 'package:should_have_bought_app/models/calculator/high_price_ten_year.dart';
import 'package:should_have_bought_app/models/calculator/result/calculator_stock_all.dart';
import 'package:should_have_bought_app/models/calculator/result/period_best_price.dart';
import 'package:should_have_bought_app/models/calculator/result/sectorData.dart';
import 'package:should_have_bought_app/models/calculator/result/best_price.dart';
import 'package:should_have_bought_app/models/calculator/current_stock_price.dart';
import 'package:should_have_bought_app/models/calculator/news_article.dart';

class CalculatorProvider with ChangeNotifier {
  List _companyList = [];
  List _searchCompanyList = [];
  String _query = '';
  List<HighPriceTenYear> _tenYearHighList = [
    HighPriceTenYear(),
    HighPriceTenYear(),
    HighPriceTenYear(),
    HighPriceTenYear()
  ];
  List<CalculatorHistory> _calculateHistory = [];
  Map latestDto;
  CalculatorStockAll _calculationResultAll;
  CalculatorStock _calculationResult;
  BestPrice _bestPriceResult;
  SectorData _sectorData;
  List<NewsArticle> _headlienList = <NewsArticle>[];
  List<PeriodBestPrice> _periodBestPriceList = <PeriodBestPrice>[];
  List<CurrentStockPrice> _currentStockPriceList = <CurrentStockPrice>[];

  CalculatorStock get calculationResult {
    return _calculationResult;
  }

  CalculatorStockAll get calculationResultAll {
    return _calculationResultAll;
  }

  BestPrice get bestPriceResult {
    return _bestPriceResult;
  }

  SectorData get sectorData {
    return _sectorData;
  }

  List get headlineList {
    return _headlienList;
  }

  List get companyList {
    return _companyList;
  }

  List get searchCompanyList {
    return _searchCompanyList;
  }

  List<HighPriceTenYear> get tenYearHighList {
    return _tenYearHighList;
  }

  List get calculateHistory {
    return _calculateHistory;
  }

  String get query => _query;

  List<CurrentStockPrice> get currentStockPriceList => _currentStockPriceList;

  List<PeriodBestPrice> get periodBestPriceList => _periodBestPriceList;

  void clearQuery() {
    _query = "";
    notifyListeners();
  }

  void filterSearchResults(String query) {
    List<Company> dummySearchList = [];
    _query = query;
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
    _calculationResult = CalculatorStock.fromJson(result);
    notifyListeners();
  }

  Future randomResult(Map params) async {
    latestDto = params;
    final result = await CalculatorApi.getResult(params);
    print(result);
    _calculationResult = CalculatorStock.fromJson(result);
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

    print(list);
    if (list != null) {
      _tenYearHighList =
          list.map((item) => HighPriceTenYear.fromJson(item)).toList();
      notifyListeners();
    }
  }

  Future getHistory({int pageNo = 1, int pageSize = 10}) async {
    var list = [];
    final result = await CalculatorApi.getHistoryList(pageNo, pageSize);
    list = result['calculationHistList'];
    if (list != null) {
      _calculateHistory = list
          .map<CalculatorHistory>(
              (history) => CalculatorHistory.fromJson(history))
          .toList();
      notifyListeners();
    }
  }

  Future getSectorData() async {
    if (_sectorData == null) {
      final result = await CalculatorApi.getSectorInfor(latestDto['code'],
          latestDto['investDate'], int.parse(latestDto['investPrice']));
      _sectorData = SectorData.fromJson(result);
      notifyListeners();
    }
  }

  Future getFourResult() async {
    if (_calculationResultAll == null) {
      final result = await CalculatorApi.getAllResult(
          latestDto['code'], int.parse(latestDto['investPrice']));
      _calculationResultAll = CalculatorStockAll.fromJson(result);
      notifyListeners();
    }
  }

  Future getBestPrice() async {
    if (_bestPriceResult == null) {
      final result = await CalculatorApi.getBestPrice(latestDto['code'],
          latestDto['investDate'], int.parse(latestDto['investPrice']));
      _bestPriceResult = BestPrice.fromJson(result);
      notifyListeners();
    }
  }

  Future getCurrentStockPrice() async {
    final result = await CalculatorApi.getCurrentStockPrice();
    print(result);
    _currentStockPriceList = result
        .map<CurrentStockPrice>(
            (currentStock) => CurrentStockPrice.fromJson(currentStock))
        .toList();
    notifyListeners();
  }

  Future getPeriodBestPrice() async {
    if (_periodBestPriceList.isEmpty) {
      final result =
          await CalculatorApi.getPeriodBestPrice(latestDto['investDate']);
      final list = result['yieldSortList'];
      if (list != null) {
        _periodBestPriceList = list
            .map<PeriodBestPrice>(
                (sortedStock) => PeriodBestPrice.fromJson(sortedStock))
            .toList();
      }
      notifyListeners();
    }
  }

  Future cleanValue() async {
    _sectorData = null;
    _bestPriceResult = null;
    _calculationResultAll = null;
    _periodBestPriceList.clear();
  }

  Future getHeadliens() async {
    final result = await CalculatorApi.getNewsTopHeadline();
    final list = result['articles'];
    if (list != null) {
      _headlienList =
          list.map<NewsArticle>((item) => NewsArticle.fromJson(item)).toList();
    }
    notifyListeners();
  }
}
