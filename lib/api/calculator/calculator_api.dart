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
        response.statusCode.toString() + ":" + response.body.toString());
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
        response.statusCode.toString() + ":" + response.body.toString());
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
        response.statusCode.toString() + ":" + response.body.toString());
  }
}
