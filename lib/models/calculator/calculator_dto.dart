import 'package:flutter/cupertino.dart';

class CalculatorDto {
  final String code;
  final String company;
  final String investDate;
  final int investPrice;

  const CalculatorDto({
    @required this.code,
    @required this.investDate,
    @required this.investPrice,
    @required this.company,
  });

  factory CalculatorDto.fromJson(dynamic json) {
    return CalculatorDto(code: json['code'], investDate: json['investDate'], investPrice: json['investPrice'], company:json['company']);
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'investDate': investDate,
      'investPrice': "$investPrice",
      'company': company
    };
  }
}