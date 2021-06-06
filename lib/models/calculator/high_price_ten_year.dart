import 'package:should_have_bought_app/models/buy_or_not/buy_or_not_chart.dart';

class HighPriceTenYear {
  final String code;
  final String company;
  final String sector;
  final String sectorKor;
  final BuyOrNotChart maxQuote;

  HighPriceTenYear({this.code = '', this.company = '', this.sector = '', this.sectorKor = '', this.maxQuote});
  factory HighPriceTenYear.fromJson(dynamic json) {
    return HighPriceTenYear(
      code: json['code'] ?? '',
      company: json['company'] ?? '',
      sector: json['sector'] ?? '',
      sectorKor: json['sectorKor'] ?? 0,
      maxQuote: BuyOrNotChart.fromJson(json['maxQuote']),
    );
  }
}