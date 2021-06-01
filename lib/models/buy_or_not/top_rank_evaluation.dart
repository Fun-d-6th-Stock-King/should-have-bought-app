class TopRankEvaluation {
  final String pros;
  final String cons;
  final String displayName;
  final String createdDate;
  final String createdDateText;

  TopRankEvaluation({
    this.pros = "",
    this.cons = "",
    this.displayName = "",
    this.createdDate = "",
    this.createdDateText = "",

  });

  factory TopRankEvaluation.fromJson(dynamic json) {
    return TopRankEvaluation(
      pros: json['pros'],
      cons: json['cons'] ?? '',
      displayName: json['displayName'] ?? '',
      createdDate: json['createdDate'] ?? '',
      createdDateText: json['createdDateText'] ?? ''
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pros': pros,
      'cons': cons,
      'displayName': displayName,
      'createdDate': createdDate,
      'createdDateText': createdDateText,
    };
  }
}
