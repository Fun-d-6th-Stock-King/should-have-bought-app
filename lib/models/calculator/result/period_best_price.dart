class PeriodBestPrice {
  final int id;
  final String code;
  final String company;
  final String sector;
  final String sectorKor;
  final String oldPrice;
  final String oldDate;
  final double yieldPercent;
  final String updatedDate;
  final String price;

  PeriodBestPrice(
      {this.id = 0,
      this.code = '',
      this.company = '',
      this.sector = '',
      this.sectorKor = '',
      this.oldPrice = '',
      this.oldDate = '',
      this.yieldPercent = 0.0,
      this.price = '',
      this.updatedDate = ''});

  factory PeriodBestPrice.fromJson(Map<dynamic, dynamic> map) {
    return PeriodBestPrice(
        id: map['id'],
        code: map['code'],
        company: map['company'],
        sector: map['sector'],
        sectorKor: map['sectorKor'],
        oldPrice: map['oldPrice'].toString(),
        oldDate: map['oldDate'],
        yieldPercent: map['yieldPercent'],
        updatedDate: map['updatedDate'],
        price: map['price'].toString());
  }
}
