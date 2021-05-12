import 'dart:convert';

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
  static Future setEvaluation(Map data) async {

    Map<String, String> header = await Api.getHeader();

    final response = await http.post(
      Uri.parse("$stockApiUrl/api/buyornot"),
      headers: header,
      body: jsonEncode(data),
    );
    print('[POST]] /api/buyornot');
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

}