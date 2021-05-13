import 'package:flutter/material.dart';

class PageInfo {
  final int pageSize;
  final int pageNo;
  final int count;

  PageInfo(
      {@required this.pageSize, @required this.pageNo, @required this.count});

  factory PageInfo.fromJson(dynamic json) {
    return PageInfo(
        pageSize: json['pageSize'] ,
        pageNo: json['pageNo'] ?? 1,
        count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pageSize': pageSize,
      'pageNo': pageNo,
      'count': count,
    };
  }
}