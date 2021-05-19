import 'package:flutter/material.dart';
import 'package:should_have_bought_app/api/drip_room/drip_room_api.dart';
import 'package:should_have_bought_app/api/today_word/today_word_api.dart';
import 'package:should_have_bought_app/models/drip_room/evaluation_item.dart';
import 'package:should_have_bought_app/models/today_word/word_item.dart';
import 'package:should_have_bought_app/models/util/page_info.dart';

class TodayWordProvider with ChangeNotifier {
  List _wordItemList = [];
  PageInfo _pageInfo = PageInfo();
  WordItem _todayBest = WordItem();

  List get wordItemList => _wordItemList;
  PageInfo get pageInfo => _pageInfo;
  WordItem get todayBest => _todayBest;

  Future getWordList(Map<String, dynamic> params) async {
    final result = await TodayWordApi.getWordList(params);
    print(result);
    List list = result['todayWordResList'];
    _pageInfo = PageInfo.fromJson(result['pageInfo']);
    print(_wordItemList.length);
    var addWordItemList =
        list.map((wordItem) => WordItem.fromJson(wordItem)).toList();
    _wordItemList = [..._wordItemList, ...addWordItemList];

    notifyListeners();

    return addWordItemList;
  }

  Future getTodayBest() async {
    final result = await TodayWordApi.getBestWord();
    _todayBest = WordItem.fromJson(result);
    print(result);
    notifyListeners();
  }
}
