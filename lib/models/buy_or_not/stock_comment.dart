class StockComment {
  String comment;
  String createdDate;
  String displayName;
  int id;
  String uid;

  StockComment.fromJson(Map<dynamic, dynamic> map) {
    comment = map['comment'] ?? '';
    createdDate = map['createdDate'] ?? '';
    displayName = map['displayName'] ?? '';
    id = map['id'] ?? 0;
    uid = map['uid'] ?? '';
  }
}
