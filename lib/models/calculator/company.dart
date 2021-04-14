class Company {
  final String company;
  final String code;

  Company(this.company, this.code);

  Map<String, dynamic> toMap() {
    return {
      'company': company,
      'code': code,
    };
  }
}
