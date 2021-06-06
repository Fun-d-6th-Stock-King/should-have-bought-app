

import 'package:flutter/material.dart';

class EvaluationItem {
  final int id;
  final String code;
  final String company;
  final String pros;
  final String cons;
  final String uid;
  final int likeCount;
  final String displayName;
  final String createdDate;
  final bool userlike;

  EvaluationItem(
      {@required this.id, @required this.code, @required this.company, @required this.pros, @required this.cons, @required this.uid, @required this.likeCount, @required this.displayName, @required this.createdDate, @required this.userlike});

  factory EvaluationItem.fromJson(dynamic json) {
    return EvaluationItem(
        id: json['id'],
        code: json['code'] ?? '',
        company: json['company'] ?? '',
        pros: json['pros'] ?? '',
        cons: json['cons'] ?? '',
        uid: json['uid'] ?? '',
        likeCount: json['likeCount'] ?? 0,
        displayName: json['displayName'] ?? '닉네임',
        createdDate: json['createdDate'] ?? '',
        userlike: json['userlike'] ?? false,
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
      'likeCount': likeCount,
      'displayName': displayName,
      'createdDate': createdDate,
      'userlike': userlike,
    };
  }

  @override
  int get hashCode => company.hashCode ^ code.hashCode;

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
          other is EvaluationItem && code == other.code && company == other.company;
}
