import 'package:flutter/material.dart';
import 'package:should_have_bought_app/api/drip_room/drip_room_api.dart';
import 'package:should_have_bought_app/models/drip_room/evaluation_item.dart';

class DripRoomProvider with ChangeNotifier {
  List _evaluationItemList = [];
  EvaluationItem _todayBest = EvaluationItem();

  List get evaluationItemList => _evaluationItemList;
  EvaluationItem get todayBest => _todayBest;

  Future getEvaluationList(Map<String, dynamic> params) async {
    final result = await DripRoomApi.getEvaluationList(params);
    print(result);
    List list = result['simpleEvaluationList'];
    _evaluationItemList = list.map((evaluationItem) => EvaluationItem.fromJson(evaluationItem)).toList();

    notifyListeners();
  }

  Future getTodayBest() async {
    final result = await DripRoomApi.getTodayBest();
    _todayBest = EvaluationItem.fromJson(result);
    print(result);
    notifyListeners();
  }
}