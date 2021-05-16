class SectorData {
  int kospiYieldPercent;
  String kospiOldDate;
  double kospiOldStock;
  double kospiCurrentStock;
  String kospiCurrentTime;
  String sector;
  String sectorKor;
  int industrYieldPercent;
  List companies;
  int companyCnt;

  SectorData.fromJson(Map<dynamic, dynamic> map) {
    kospiYieldPercent = map['kospiValue']['yieldPercent'].toInt();
    kospiOldDate =
        map['kospiValue']['oldDate'].split(" ")[0].replaceAll('.', '');
    kospiOldStock = map['kospiValue']['oldStock'].toDouble();
    kospiCurrentStock = map['kospiValue']['currentStock'].toDouble();
    kospiCurrentTime =
        map['kospiValue']['currentTime'].split(" ")[0].replaceAll('.', '');
    sector = map['industryValue']['sector'];
    sectorKor = map['industryValue']['sectorKor'];
    industrYieldPercent = map['industryValue']['yieldPercent'].toInt();
    companies = map['industryValue']['companies'];
    companyCnt = map['industryValue']['companyCnt'];
  }
}
