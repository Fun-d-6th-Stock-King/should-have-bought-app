import 'package:flutter/material.dart';

class WordItem {
  final int id;
  final String wordName;
  final String mean;
  final String createdUid;
  final String createdDate;
  int likeCount;
  bool userlike;
  final String displayName;
  final String createdDateText;

  WordItem(
      {@required this.id,
      this.wordName = '',
      this.mean = '',
      this.createdUid = '',
      this.createdDate = '',
      this.likeCount = 0,
      this.userlike = false,
      this.displayName = '',
      this.createdDateText = ''});

  factory WordItem.fromJson(dynamic json) {
    return WordItem(
      id: json['id'],
      wordName: json['wordName'] ?? '',
      mean: json['mean'] ?? '',
      createdUid: json['createdUid'] ?? '',
      createdDate: json['createdDate'] ?? '',
      likeCount: json['likeCount'] ?? false,
      userlike: json['userlike'] ?? 0,
      displayName: json['displayName'] ?? '',
      createdDateText: json['createdDateText'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'wordName': wordName,
      'mean': mean,
      'createdUid': createdUid,
      'createdDate': createdDate,
      'likeCount': likeCount,
      'userlike': userlike,
      'displayName': displayName,
      'createdDateText': createdDateText
    };
  }

  @override
  int get hashCode => wordName.hashCode;

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) || other is WordItem && id == other.id;
}
