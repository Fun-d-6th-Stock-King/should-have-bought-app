import 'package:should_have_bought_app/models/buy_or_not/stock_comment.dart';

class StockEvaluationItem {
  int commentCount;
  int id;
  int likeCount;
  String code;
  String company;
  String cons;
  String createDate;
  String displayName;
  String giphyImgId;
  String pros;
  String uid;
  bool userLike;
  StockComment recentComment;

  StockEvaluationItem.fromJson(Map<dynamic, dynamic> map) {
    commentCount = map['commentCount'];
    id = map['id'];
    likeCount = map['likeCount'];
    code = map['code'];
    company = map['company'];
    cons = map['cons'];
    createDate = map['createdDate'];
    displayName = map['displayName'];
    giphyImgId = map['giphyImgId'];
    pros = map['pros'];
    uid = map['uid'];
    userLike = map['userLike'];
    if (map['recentComment'] != null) {
      recentComment = StockComment.fromJson(map['recentComment']);
    } else {
      recentComment = null;
    }
  }
}
