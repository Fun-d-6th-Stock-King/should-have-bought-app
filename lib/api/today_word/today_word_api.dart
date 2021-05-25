import 'dart:convert';

import '../api.dart';
import 'package:http/http.dart' as http;

class TodayWordApi extends Api {
  /// 최고의 단어 조회 api
  static Future getBestWord() async {
    var header = await Api.getHeader();

    final response = await http.get(
      Uri.parse("$stockApiUrl/api/todayWord/topWord"),
      headers: header,
    );
    print('[GET] /api/todayWord/topWord');
    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      return responseBody;
    }
    throw Exception(
        "${response.statusCode}:${utf8.decode(response.bodyBytes)}");
  }

  /// 단어저장 api
  static Future saveWord(Map data) async {
    var header = await Api.getHeader();

    final response = await http.post(
      Uri.parse("$stockApiUrl/api/todayWord"),
      headers: header,
      body: jsonEncode(data),
    );
    print('[POST] /api/todayWord');
    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      return responseBody;
    }
    throw Exception(
        "${response.statusCode}:${utf8.decode(response.bodyBytes)}");
  }

  /// 단어 목록 조회 api
  static Future getWordList(Map<String, dynamic> params) async {
    print(params);
    var header = await Api.getHeader();
    final response = await http.get(
      Uri.parse("$stockApiUrl/api/todayWord/list")
          .replace(queryParameters: params),
      headers: header,
    );

    print('[GET] /api/todayWord/list');
    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      return responseBody;
    }
    throw Exception(
        "${response.statusCode}:${utf8.decode(response.bodyBytes)}");
  }

  /// 단어 좋아요 선택
  static Future saveWordLike(String id, Map params) async {
    var header = await Api.getHeader();
    final response = await http.get(
      Uri.parse("$stockApiUrl/api/todayWord/$id/like")
          .replace(queryParameters: params),
      headers: header,
    );
    print('[GET] /api/todayWord/$id/like');
    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      return responseBody;
    }
    throw Exception(
        "${response.statusCode}:${utf8.decode(response.bodyBytes)}");
  }

}
