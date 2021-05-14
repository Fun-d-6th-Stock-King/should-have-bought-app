import 'dart:convert';

import '../api.dart';
import 'package:http/http.dart' as http;

class BuyOrNotApi extends Api{
  static Future getBuyOrNotStock(String stockCode) async {

    Map<String, String> header = await Api.getHeader();
    final response = await http.get(
      Uri.parse("$stockApiUrl/api/buyornot/$stockCode"),
      headers: header,
    );
    print('[GET] /api/buyornot/:stockCode');
    print(response.statusCode);
    if(response.statusCode == 200) {
      final resposeBody = json.decode(utf8.decode(response.bodyBytes));
      return resposeBody;
    }
    throw Exception(response.statusCode.toString()+":"+response.body.toString());
  }

  //TODO: 정민님 POST API 구현

}