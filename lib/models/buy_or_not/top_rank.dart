import 'package:flutter/cupertino.dart';
import 'package:should_have_bought_app/models/buy_or_not/top_rank_evaluation.dart';
import 'package:should_have_bought_app/models/buy_or_not/top_rank_item.dart';

class TopRank {
  final TopRankEvaluation topRankEvaluation;
  final List<TopRankItem> topRankList;

  TopRank({this.topRankEvaluation, @required this.topRankList});
  factory TopRank.fromJson(dynamic json) {
    return TopRank(
      topRankEvaluation: TopRankEvaluation.fromJson(json['rankTop']),
      topRankList: json['groupResultList']
          .map<TopRankItem>((value) => TopRankItem.fromJson(value))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'topRankEvaluation': topRankEvaluation.toMap(),
      'topRankList': topRankList.map((topRankItem) => topRankItem.toMap())
        .toList(),
    };
  }
}