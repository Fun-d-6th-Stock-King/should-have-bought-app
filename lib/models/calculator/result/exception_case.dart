class ExceptionCase {
  bool isExceptCase;
  bool isDateExcept;
  String oldInvestDate;
  String newInvestDate;
  bool isPriceExcept;
  int oldInvestPrice;
  int newInvestPrice;
  bool isStockExcept;
  bool isTradingHalt;
  bool isInvestmentAlert;
  bool isManagement;

  ExceptionCase.fromJson(Map<dynamic, dynamic> map) {
    isExceptCase = map['isExceptCase'];
    isDateExcept = map['isDateExcept'];
    oldInvestDate = map['oldInvestDate'];
    newInvestDate = map['newInvestDate'];
    isPriceExcept = map['isPriceExcept'];
    oldInvestPrice = map['oldInvestPrice'];
    newInvestPrice = map['newInvestPrice'];
    isStockExcept = map['isStockExcept'];
    isTradingHalt = map['isTradingHalt'];
    isInvestmentAlert = map['isInvestmentAlert'];
    isManagement = map['isManagement'];
  }
}
