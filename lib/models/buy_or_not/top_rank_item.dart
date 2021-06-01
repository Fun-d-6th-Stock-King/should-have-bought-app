class TopRankItem {
  final String code;
  final String company;
  final double currentPrice;
  final double change;
  final double changeInPercent;
  final int buyCnt;
  final int sellCnt;

  TopRankItem({
    this.code = "",
    this.company = "",
    this.currentPrice = 0,
    this.change = 0,
    this.changeInPercent = 0,
    this.buyCnt = 0,
    this.sellCnt = 0,
  });

  factory TopRankItem.fromJson(dynamic json) {
    return TopRankItem(
        code: json['code'] ?? '',
        company: json['company'] ?? '',
        currentPrice: json['currentPrice'] ?? 0,
        change: json['change'] ?? 0,
        changeInPercent: json['changeInPercent'] ?? 0,
        buyCnt: json['buyCnt'],
        sellCnt: json['sellCnt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'company': company,
      'currentPrice': currentPrice,
      'change': change,
      'changeInPercent': changeInPercent,
      'buyCnt': buyCnt,
      'sellCnt': sellCnt,
    };
  }
}
