

import 'package:flutter/material.dart';

class EvaluationItem {
  final int id;
  final String code;
  final String company;
  final String pros;
  final String cons;
  final String uid;
  final int likeCount;

  EvaluationItem(
      {@required this.id, @required this.code, @required this.company, @required this.pros, @required this.cons, @required this.uid, @required this.likeCount});

  factory EvaluationItem.fromJson(dynamic json) {
    return EvaluationItem(
        id: json['id'],
        code: json['code'] ?? '',
        company: json['company'] ?? '',
        pros: json['pros'] ?? '',
        cons: json['cons'] ?? '',
        uid: json['uid'] ?? '',
        likeCount: json['likeCount'] ?? 0
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'company': company,
      'pros': pros,
      'cons': cons,
      'uid': uid,
      'likeCount': likeCount
    };
  }

  @override
  int get hashCode => company.hashCode ^ code.hashCode;

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
          other is EvaluationItem && code == other.code && company == other.company;
}
