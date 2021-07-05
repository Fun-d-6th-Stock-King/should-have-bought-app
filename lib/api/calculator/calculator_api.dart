import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api.dart';

class CalculatorApi extends Api {
  static Future getResult(Map params) async {
    print(Uri.parse("$stockApiUrl/api/buythen/calculate")
        .replace(queryParameters: params));

    Map<String, String> header = await Api.getHeader();

    final response = await http.get(
        Uri.parse("$stockApiUrl/api/buythen/calculate")
            .replace(queryParameters: params),
        headers: header);
    print('[GET] /api/buythen/calculate');
    print(response.statusCode);
    if (response.statusCode == 200) {
      final resposeBody = json.decode(utf8.decode(response.bodyBytes));
      return resposeBody;
    }
    throw Exception(
        '${response.statusCode.toString()} : ${utf8.decode(response.bodyBytes)}');
  }

  static Future getCompanies() async {
    Map<String, String> header = await Api.getHeader();

    final response =
        await http.get(Uri.parse("$stockApiUrl/api/buythen"), headers: header);
    print('[GET] /api/buythen');
    print(response.statusCode);
    if (response.statusCode == 200) {
      final resposeBody = json.decode(utf8.decode(response.bodyBytes));
      return resposeBody;
    }
    throw Exception(
        '${response.statusCode.toString()} : ${utf8.decode(response.bodyBytes)}');
  }

  static Future getHistoryList(int pageNo, int pageSize) async {
    final response = await http.get(
      Uri.parse(
          "$stockApiUrl/api/buythen/calculation-history?pageNo=$pageNo&pageSize=$pageSize"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      return responseBody;
    }
    throw Exception(
        '${response.statusCode.toString()} : ${utf8.decode(response.bodyBytes)}');
  }

  static Future getTenYearHigher() async {
    Map<String, String> header = await Api.getHeader();

    final response = await http.get(
        Uri.parse("$stockApiUrl/api/buythen/high-price-10year"),
        headers: header);
    print('[GET] /api/buythen/high-price-10year');
    if (response.statusCode == 200) {
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      return responseBody;
    }
    throw Exception(
        '${response.statusCode.toString()} : ${utf8.decode(response.bodyBytes)}');
  }

  static Future getSectorInfor(
      String code, String investDate, int investPrice) async {
    Map<String, String> header = await Api.getHeader();

    final response = await http.get(
        Uri.parse(
            "$stockApiUrl/api/buythen/current-kospi-industry?code=$code&investDate=$investDate&investPrice=$investPrice"),
        headers: header);

    if (response.statusCode == 200) {
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      return responseBody;
    }
    throw Exception(
        '${response.statusCode.toString()} : ${utf8.decode(response.bodyBytes)}');
  }

  static Future getAllResult(String code, int investPrice) async {
    Map<String, String> header = await Api.getHeader();

    final response = await http.get(
        Uri.parse(
            "$stockApiUrl/api/buythen/calc-all-date?code=$code&investPrice=$investPrice"),
        headers: header);

    if (response.statusCode == 200) {
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      return responseBody;
    }
    throw Exception(
        '${response.statusCode.toString()} : ${utf8.decode(response.bodyBytes)}');
  }

  static Future getBestPrice(
      String code, String investDate, int investPrice) async {
    Map<String, String> header = await Api.getHeader();

    final response = await http.get(
        Uri.parse(
            "$stockApiUrl/api/buythen/calc-highest?code=$code&investDate=$investDate&investPrice=$investPrice"),
        headers: header);

    if (response.statusCode == 200) {
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      return responseBody;
    }
    throw Exception(
        '${response.statusCode.toString()} : ${utf8.decode(response.bodyBytes)}');
  }

  static Future getCurrentStockPrice() async {
    Map<String, String> header = await Api.getHeader();
    final response = await http.get(
      Uri.parse("$stockApiUrl/api/buythen/high-row"),
      headers: header,
    );
    print('[GET] /api/buythen/high-row');
    print(response.statusCode);

    if (response.statusCode == 200) {
      final resposeBody = json.decode(utf8.decode(response.bodyBytes));
      return resposeBody;
    }
    throw Exception(
        '${response.statusCode.toString()} : ${utf8.decode(response.bodyBytes)}');
  }

  static Future getPeriodBestPrice(String investDate) async {
    Map<String, String> header = await Api.getHeader();
    final response = await http.get(
      Uri.parse(
          "$stockApiUrl/api/buythen/yield-list/BUY/$investDate?pageNo=1&pageSize=3"),
      headers: header,
    );

    if (response.statusCode == 200) {
      final resposeBody = json.decode(utf8.decode(response.bodyBytes));
      return resposeBody;
    }
    throw Exception(
        '${response.statusCode.toString()} : ${utf8.decode(response.bodyBytes)}');
  }

  static Future getNewsTopHeadline() async {
    print('$newsApiKey');
    final response = await http.get(
      Uri.parse(
          "https://newsapi.org/v2/top-headlines?apiKey=$newsApiKey&country=kr&category=business"),
    );
    if (response.statusCode == 200) {
      final resposeBody = json.decode(utf8.decode(response.bodyBytes));
      return resposeBody;
    }
    throw Exception(
        '${response.statusCode.toString()} : ${utf8.decode(response.bodyBytes)}');
  }
}
