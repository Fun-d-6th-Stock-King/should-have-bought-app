import 'package:flutter/material.dart';
import 'package:should_have_bought_app/api/drip_room/drip_room_api.dart';
import 'package:should_have_bought_app/models/buy_or_not/stock_evaluation_item.dart';
import 'package:should_have_bought_app/models/buy_or_not/stock_evaluation_list.dart';
import 'package:should_have_bought_app/models/drip_room/evaluation_item.dart';
import 'package:should_have_bought_app/models/util/page_info.dart';

class DripRoomProvider with ChangeNotifier {
  List _evaluationItemList = [];
  PageInfo _pageInfo = PageInfo();
  EvaluationItem _todayBest = EvaluationItem();
  StockEvaluationList _bestStockEvaluationList = StockEvaluationList();
  StockEvaluationList _stockEvaluationList = StockEvaluationList();

  bool _isLoading = false;
  bool _isSaved = false;

  StockEvaluationList get bestStockEvaluationList => _bestStockEvaluationList;
  StockEvaluationList get stockEvaluationList => _stockEvaluationList;
  List get evaluationItemList => _evaluationItemList;
  PageInfo get pageInfo => _pageInfo;
  EvaluationItem get todayBest => _todayBest;
  bool get isLoading => _isLoading;
  bool get isSaved => _isSaved;

  Future getEvaluationList(Map<String, dynamic> params) async {
    final result = await DripRoomApi.getEvaluationList(params);
    print(result);
    List list = result['simpleEvaluationList'];
    _pageInfo = PageInfo.fromJson(result['pageInfo']);
    print(_evaluationItemList);
    // List addEvaluationItemList = list.map((evaluationItem) => EvaluationItem.fromJson(evaluationItem)).toList();
    _evaluationItemList = list
        .map((evaluationItem) => EvaluationItem.fromJson(evaluationItem))
        .toList();

    notifyListeners();

    return _evaluationItemList;
  }

  Future getTodayBest() async {
    final result = await DripRoomApi.getTodayBest();
    _todayBest = EvaluationItem.fromJson(result);
    print(result);
    notifyListeners();
  }

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
  }

  Future likeDrip(int itemId) async {
    final result = await DripRoomApi.likeDrip(itemId);
    int findIndex =
        _evaluationItemList.indexWhere((element) => element.id == itemId);

    EvaluationItem findEvaluationItem = _evaluationItemList[findIndex];
    _evaluationItemList[findIndex] = EvaluationItem.fromJson({
      ...findEvaluationItem.toMap(),
      'userlike': !findEvaluationItem.userlike,
      'likeCount': result['like'] == true
          ? findEvaluationItem.likeCount + 1
          : findEvaluationItem.likeCount - 1
    });
    notifyListeners();
  }

  Future likeDripEmoji(int itemId) async {
    final result = await DripRoomApi.likeDrip(itemId);
    int findIndex = _stockEvaluationList.evaluationList
        .indexWhere((element) => element.id == itemId);

    StockEvaluationItem findEvaluationItem =
        _stockEvaluationList.evaluationList[findIndex];

    _stockEvaluationList.evaluationList[findIndex] =
        StockEvaluationItem.fromJson({
      ...findEvaluationItem.toMap(),
      'userlike': !findEvaluationItem.userlike,
      'likeCount': result['like'] == true
          ? findEvaluationItem.likeCount + 1
          : findEvaluationItem.likeCount - 1
    });

    notifyListeners();
  }

  Future likeBestDripEmoji(int itemId) async {
    final result = await DripRoomApi.likeDrip(itemId);
    int findIndex = _bestStockEvaluationList.evaluationList
        .indexWhere((element) => element.id == itemId);

    StockEvaluationItem findEvaluationItem =
        _bestStockEvaluationList.evaluationList[findIndex];
    _bestStockEvaluationList.evaluationList[findIndex] =
        StockEvaluationItem.fromJson({
      ...findEvaluationItem.toMap(),
      'userlike': !findEvaluationItem.userlike,
      'likeCount': result['like'] == true
          ? findEvaluationItem.likeCount + 1
          : findEvaluationItem.likeCount - 1
    });
    notifyListeners();
  }

  Future getBestEvaluateList(
      int pageNo, int pageSize, String period, String code) async {
    final Map<String, String> params = {
      'pageNo': pageNo.toString(),
      'pageSize': pageSize.toString(),
      'period': period,
    };
    final result = await DripRoomApi.getBestEvaluationList(code, params);
    final list = result['evaluationList'];
    _bestStockEvaluationList.evaluationList = list
        .map<StockEvaluationItem>((item) => StockEvaluationItem.fromJson(item))
        .toList();
    _bestStockEvaluationList.pageInfo = result['pageInfo'];
    notifyListeners();
  }

  Future dripSave(Map data) async {
    await DripRoomApi.dripSave(data);
    notifyListeners();
  }

  void setIsSaved(bool isSaved) {
    _isSaved = isSaved;
    notifyListeners();
  }

  Future getStockEvaluateList(
      int pageNo, int pageSize, String order, String code) async {
    final Map<String, String> params = {
      'pageNo': pageNo.toString(),
      'pageSize': pageSize.toString(),
      'order': order,
    };
    final result = await DripRoomApi.getStockEvaluationList(code, params);
    final list = result['evaluationList'];
    _stockEvaluationList.evaluationList = list
        .map<StockEvaluationItem>((item) => StockEvaluationItem.fromJson(item))
        .toList();
    _stockEvaluationList.pageInfo = result['pageInfo'];
    notifyListeners();
  }
}
