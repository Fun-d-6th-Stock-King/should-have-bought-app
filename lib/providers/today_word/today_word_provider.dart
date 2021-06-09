import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:should_have_bought_app/api/drip_room/drip_room_api.dart';
import 'package:should_have_bought_app/api/today_word/today_word_api.dart';
import 'package:should_have_bought_app/models/drip_room/evaluation_item.dart';
import 'package:should_have_bought_app/models/today_word/word_item.dart';
import 'package:should_have_bought_app/models/util/page_info.dart';

class TodayWordProvider with ChangeNotifier {
  String _order;
  String _pageNo;
  String _pageSize;

  bool _isLoading = false;

  List _wordItemList = [];
  PageInfo _pageInfo = PageInfo();
  WordItem _todayBest = WordItem();

  List get wordItemList => _wordItemList;

  PageInfo get pageInfo => _pageInfo;

  WordItem get todayBest => _todayBest;

  bool get isLoading => _isLoading;

  Future getWordList(Map<String, dynamic> params) async {
    _order = params['order'];
    _pageNo = params['pageNo'];
    _pageSize = params['pageSize'];

    print(params);
    final result = await TodayWordApi.getWordList(params);
    // print(result);
    List list = result['todayWordResList'];
    _pageInfo = PageInfo.fromJson(result['pageInfo']);
    print(_wordItemList.length);
    var addWordItemList =
        list.map((wordItem) => WordItem.fromJson(wordItem)).toList();
    // _wordItemList = [..._wordItemList, ...addWordItemList];
    _wordItemList = addWordItemList;

    notifyListeners();
    return addWordItemList;
  }

  Future getMore() async {
    _pageNo = (int.parse(_pageNo) + 1).toString();
    var parmeters = <String, dynamic>{
      'order': _order,
      'pageNo': _pageNo,
      'pageSize': _pageSize
    };

    final result = await TodayWordApi.getWordList(parmeters);

    List list = result['todayWordResList'];
    _pageInfo = PageInfo.fromJson(result['pageInfo']);

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

  Future likeWord(WordItem wordItem) async {
    final result = await TodayWordApi.saveWordLike(wordItem.id);
    var _target = WordItem.fromJson(result);
    wordItem.userlike = _target.userlike;
    wordItem.likeCount = _target.likeCount;
    print(result);
    notifyListeners();
  }

  Future saveWord(Map data) async {
    await TodayWordApi.saveWord(data);
    notifyListeners();
  }
}
