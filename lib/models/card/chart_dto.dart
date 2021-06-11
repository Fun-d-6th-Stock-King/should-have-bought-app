import 'package:should_have_bought_app/models/buy_or_not/stock_hist.dart';
import 'package:should_have_bought_app/models/drip_room/evaluation_item.dart';

class ChartDto {
  final EvaluationItem evaluation;
  final StockHist stockHist;

  ChartDto({this.evaluation, this.stockHist});

  factory ChartDto.fromJson(dynamic json) {
    return ChartDto(
      stockHist: json['stockHist'],
      evaluation: json['evaluation'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'evaluation': evaluation.toMap(),
      'stockHist': stockHist.toMap(),
    };
  }
}
