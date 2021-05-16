import 'package:flutter/material.dart';
import 'package:should_have_bought_app/api/drip_room/drip_room_api.dart';
import 'package:should_have_bought_app/models/drip_room/evaluation_item.dart';
import 'package:should_have_bought_app/models/util/page_info.dart';

class DripRoomProvider with ChangeNotifier {
  List _evaluationItemList = [];
  PageInfo _pageInfo = PageInfo();
  EvaluationItem _todayBest = EvaluationItem();

  List get evaluationItemList => _evaluationItemList;
  PageInfo get pageInfo => _pageInfo;
  EvaluationItem get todayBest => _todayBest;

  Future getEvaluationList(Map<String, dynamic> params) async {
    final result = await DripRoomApi.getEvaluationList(params);
    print(result);
    List list = result['simpleEvaluationList'];
    _pageInfo = PageInfo.fromJson(result['pageInfo']);
    print(_evaluationItemList.length);
    List addEvaluationItemList = list.map((evaluationItem) => EvaluationItem.fromJson(evaluationItem)).toList();
    _evaluationItemList = [..._evaluationItemList, ...addEvaluationItemList];

    notifyListeners();

    return addEvaluationItemList;
  }

  Future getTodayBest() async {
    final result = await DripRoomApi.getTodayBest();
    _todayBest = EvaluationItem.fromJson(result);
    print(result);
    notifyListeners();
  }
}