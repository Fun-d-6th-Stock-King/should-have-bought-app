import 'package:flutter/material.dart';

class WordItem {
  final int id;
  final String wordName;
  final String mean;
  final String createdUid;
  final String createdDate;
  final int likeCount;
  final bool userlike;

  WordItem(
      {@required this.id,
      @required this.wordName,
      @required this.mean,
      this.createdUid,
      this.createdDate,
      this.likeCount,
      this.userlike});

  factory WordItem.fromJson(dynamic json) {
    return WordItem(
      id: json['id'],
      wordName: json['wordName'] ?? '',
      mean: json['mean'] ?? '',
      createdUid: json['createdUid'] ?? '',
      createdDate: json['createdDate'] ?? '',
      likeCount: json['likeCount'] ?? false,
      userlike: json['userlike'] ?? 0,
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
      'userlike': userlike
    };
  }

  @override
  int get hashCode => wordName.hashCode ;

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      other is WordItem && wordName == other.wordName;
}
