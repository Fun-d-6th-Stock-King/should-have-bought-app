import 'package:flutter/cupertino.dart';

class CalculatorDto {
  final String code;
  final String investDate;
  final int investPrice;

  const CalculatorDto({
    @required this.code,
    @required this.investDate,
    @required this.investPrice
  });

  factory CalculatorDto.fromJson(dynamic json) {
    return CalculatorDto(code: json['code'], investDate: json['investDate'], investPrice: json['investPrice']);
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'investDate': investDate,
      'investPrice': "$investPrice",
    };
  }
}