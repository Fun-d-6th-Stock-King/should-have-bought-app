class CalculatorHistory {
  String id;
  String code;
  String company;
  String investDate;
  String investDateName;
  String investPrice;
  String yieldPrice;
  int yieldPercent;
  String price;
  String createdDate;
  String createdUid;
  String sector;
  String sectorKor;
  String createdDateText;

  CalculatorHistory.fromJson(Map<dynamic, dynamic> map) {
    id = map['id'].toString();
    code = map['code'];
    company = map['company'];
    investDate = map['investDate'];
    investDateName = map['investDateName'];
    investPrice = map['investPrice'].toString();
    yieldPrice = map['yieldPrice'].toString();
    yieldPercent = map['yieldPercent'].toInt();
    price = map['price'].toString();
    createdDate = map['createdDate'];
    createdUid = map['createdUid'];
    sector = map['sector'];
    sectorKor = map['sectorKor'];
    createdDateText = map['createdDateText'];
  }
}
