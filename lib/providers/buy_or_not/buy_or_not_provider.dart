import 'package:flutter/material.dart';
import 'package:should_have_bought_app/api/buy_or_not/buy_or_not_api.dart';

class BuyOrNotProvider with ChangeNotifier {
  List _evaluationList = [];

  List get evaluationList => _evaluationList;

  Future getEvaluationLists() async {
    final result = await BuyOrNotApi.getEvaluationLists();
    print(result);
    List list = result['evaluationList'];

    //_companyList = list.map((company) => Company.fromJson(company)).toList();
    //_searchCompanyList = [..._companyList];

    //print(_companyList[1].code);
    //notifyListeners();
  }
}