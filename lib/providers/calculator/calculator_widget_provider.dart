import 'package:flutter/material.dart';
import 'package:should_have_bought_app/models/calculator/calculator_dto.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';

class CalculatorWidgetProvider with ChangeNotifier {
  String _selectedDateValue = 'YEAR10';
  Company _selectedCompany = Company(company: '삼성전자', code: '005930');
  String _price = '100000';
  bool _isLoading = false;
  CalculatorDto _sendCalcuatorDto = CalculatorDto(code: '',investDate: '', investPrice: 0);

  bool get isLoading => _isLoading;
  String get selectedDateValue => _selectedDateValue;
  Company get selectedCompany => _selectedCompany;
  String get price => _price;
  CalculatorDto get sendCalcuatorDto => _sendCalcuatorDto;

  void setSelectedDateValue(String selectedDateValue) {
    _selectedDateValue = selectedDateValue;
    notifyListeners();
  }

  void setCompanyValue(Company company) {
    _selectedCompany = company;
    notifyListeners();
  }

  void setCompanyAndDateValue(Company company, String selectedDateValue, {String price = '100000'}) {
    _selectedDateValue = selectedDateValue;
    _selectedCompany = company;
    _price = price;
    notifyListeners();
  }

  void setLoading(bool isloading) {
    _isLoading = isloading;
    notifyListeners();
  }
  void setSendCalcuatorDto(CalculatorDto sendCalcuatorDto) {
    _sendCalcuatorDto =sendCalcuatorDto;
    notifyListeners();
  }
}