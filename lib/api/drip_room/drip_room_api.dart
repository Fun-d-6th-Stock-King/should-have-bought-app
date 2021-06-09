import 'dart:convert';

import 'package:should_have_bought_app/api/buy_or_not/buy_or_not_api.dart';
import 'package:should_have_bought_app/models/buy_or_not/stock_hist.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';

import '../api.dart';
import 'package:http/http.dart' as http;

class DripRoomApi extends Api{
  static Future getTodayBest() async {

    Map<String, String> header = await Api.getHeader();

    final response = await http.get(
      Uri.parse("$stockApiUrl/api/buyornot/today-best"),
      headers: header,
    );
    print('[GET] /api/buyornot/today-best');
    print(response.statusCode);
    if(response.statusCode == 200) {
      final resposeBody = json.decode(utf8.decode(response.bodyBytes));
      return resposeBody;
    }
    throw Exception(response.statusCode.toString()+":"+ utf8.decode(response.bodyBytes));
  }

  static Future getEvaluationList(Map<String, dynamic> params) async {
    print(params);
    Map<String, String> header = await Api.getHeader();
    final response = await http.get(
      Uri.parse("$stockApiUrl/api/buyornot")
          .replace(queryParameters: params),
      headers: header,
    );

    print('[GET] /api/buyornot');
    print(response.statusCode);
    if(response.statusCode == 200) {
      final resposeBody = json.decode(utf8.decode(response.bodyBytes));
      return resposeBody;
    }
    throw Exception(response.statusCode.toString()+":"+ utf8.decode(response.bodyBytes));
  }

  static Future getBestEvaluationList(String stockCode, Map params) async {
    Map<String, String> header = await Api.getHeader();
    final response = await http.get(
      Uri.parse("$stockApiUrl/api/buyornot/$stockCode/best")
          .replace(queryParameters: params),
      headers: header,
    );
    print('[GET] /api/:stockCode/best');
    print(response.statusCode);
    if(response.statusCode == 200) {
      final resposeBody = json.decode(utf8.decode(response.bodyBytes));
      return resposeBody;
    }
    throw Exception(response.statusCode.toString()+":"+ utf8.decode(response.bodyBytes));
  }

  static Future likeDrip(int evaluateId) async {
    var header = await Api.getHeader();

    final response = await http.post(
      Uri.parse("$stockApiUrl/api/evaluate/${evaluateId}/like"),
      headers: header,
    );
    print('[POST] /api/evaluate/:evaluateId/like');
    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      return responseBody;
    }
    throw Exception(
        "${response.statusCode}:${utf8.decode(response.bodyBytes)}");
  }

  static Future noEvalList() async {
    var header = await Api.getHeader();

    final response = await http.get(
      Uri.parse("$stockApiUrl/api/evaluate/no-eval-list"),
      headers: header,
    );
    print('[GET] /api/evaluate/no-eval-list');
    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      return responseBody;
    }
    throw Exception(
        "${response.statusCode}:${utf8.decode(response.bodyBytes)}");
  }

}