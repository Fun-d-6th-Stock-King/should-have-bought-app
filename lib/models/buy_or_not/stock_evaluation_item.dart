import 'package:should_have_bought_app/models/buy_or_not/stock_comment.dart';

class StockEvaluationItem {
  final int commentCount;
  final int id;
  final int likeCount;
  final String code;
  final String company;
  final String cons;
  final String createdDate;
  final String displayName;
  final String giphyImgId;
  final String pros;
  final String uid;
  final bool userlike;
  final StockComment recentComment;

  StockEvaluationItem({
    this.commentCount,
    this.id,
    this.likeCount,
    this.code,
    this.company,
    this.cons,
    this.createdDate,
    this.displayName,
    this.giphyImgId,
    this.pros,
    this.uid,
    this.userlike,
    this.recentComment,
  });

  factory StockEvaluationItem.fromJson(Map<dynamic, dynamic> map) {
    StockComment recentComment;
    if (map['recentComment'] != null) {
      recentComment = StockComment.fromJson(map['recentComment']);
    } else {
      recentComment = null;
    }
    return StockEvaluationItem(
      commentCount: map['commentCount'] ?? 0,
      id: map['id'],
      likeCount: map['likeCount'] ?? 0,
      code: map['code'] ?? '',
      company: map['company'] ?? '',
      cons: map['cons'] ?? '',
      createdDate: map['createdDate'] ?? '',
      displayName: map['displayName'] ?? '',
      giphyImgId: map['giphyImgId'] ?? '',
      pros: map['pros'] ?? '',
      uid: map['uid'] ?? '',
      userlike: map['userlike'] ?? false,
      recentComment: recentComment,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'company': company,
      'pros': pros,
      'cons': cons,
      'giphyImgId': giphyImgId,
      'uid': uid,
      'likeCount': likeCount,
      'displayName': displayName,
      'createdDate': createdDate,
      'userlike': userlike,
      'commentCount': commentCount,
      'recentComment': recentComment,
    };
  }
}
