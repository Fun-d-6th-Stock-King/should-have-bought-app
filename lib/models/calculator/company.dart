import 'package:flutter/cupertino.dart';

class Company {
  final String company;
  final String code;

  Company({@required this.company, @required this.code});

  factory Company.fromJson(dynamic json) {
    return Company(company: json['company'], code: json['code']);
  }

  Map<String, dynamic> toMap() {
    return {
      'company': company,
      'code': code,
    };
  }

  @override
  int get hashCode => company.hashCode ^ code.hashCode;

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) || other is Company && code == other.code && company == other.company;
}
