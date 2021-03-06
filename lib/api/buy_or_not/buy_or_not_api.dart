import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api.dart';

class BuyOrNotApi extends Api {
  static Future getBuyOrNotStock(String stockCode) async {
    Map<String, String> header = await Api.getHeader();
    final response = await http.get(
      Uri.parse("$stockApiUrl/api/buyornot/$stockCode"),
      headers: header,
    );
    print('[GET] /api/buyornot/:stockCode');
    print(response.statusCode);
    if (response.statusCode == 200) {
      final resposeBody = json.decode(utf8.decode(response.bodyBytes));
      return resposeBody;
    }
    throw Exception(
        '${response.statusCode.toString()} : ${utf8.decode(response.bodyBytes)}');
  }

  static Future getBuyOrNotStockChart(String stockCode) async {
    Map<String, String> header = await Api.getHeader();
    final response = await http.get(
      Uri.parse("$stockApiUrl/api/buyornot/$stockCode/chart"),
      headers: header,
    );
    print('[GET] /api/buyornot/:stockCode/chart');
    print(response.statusCode);
    if (response.statusCode == 200) {
      final resposeBody = json.decode(utf8.decode(response.bodyBytes));
      return resposeBody;
    }
    throw Exception(
        '${response.statusCode.toString()} : ${utf8.decode(response.bodyBytes)}');
  }

  static Future setBuyOrNotStock(String stockCode, Map data) async {
    Map<String, String> header = await Api.getHeader();

    final response = await http.post(
      Uri.parse("$stockApiUrl/api/buyornot/$stockCode")
          .replace(queryParameters: data),
      headers: header,
    );
    print('[POST] /api/buyornot/:stockCode');
    print(response.statusCode);
    if (response.statusCode == 200) {
      final resposeBody = json.decode(utf8.decode(response.bodyBytes));
      return resposeBody;
    }
    throw Exception(
        '${response.statusCode.toString()} : ${utf8.decode(response.bodyBytes)}');
  }

  static Future getBuyRankList(String buySell, String rankListType) async {
    Map<String, String> header = await Api.getHeader();
    final response = await http.get(
      Uri.parse(
          "$stockApiUrl/api/buyornot/getBuyRankList/$buySell/$rankListType"),
      headers: header,
    );
    print('[GET] /api/buyornot/getBuyRankList/:buySell/:rankListType');
    print(response.statusCode);

    if (response.statusCode == 200) {
      final resposeBody = json.decode(utf8.decode(response.bodyBytes));
      return resposeBody;
    }
    throw Exception(
        '${response.statusCode.toString()} : ${utf8.decode(response.bodyBytes)}');
  }

  static Future getBestEvaluateList(String stockCode, Map params) async {
    Map<String, String> header = await Api.getHeader();
    final response = await http.get(
      Uri.parse("$stockApiUrl/api/buyornot/$stockCode/best")
          .replace(queryParameters: params),
      headers: header,
    );
    if (response.statusCode == 200) {
      final resposeBody = json.decode(utf8.decode(response.bodyBytes));
      return resposeBody;
    }
    throw Exception(
        '${response.statusCode.toString()} : ${utf8.decode(response.bodyBytes)}');
  }
}
