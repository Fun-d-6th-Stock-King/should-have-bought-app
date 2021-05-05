import 'dart:convert';

import '../api.dart';
import 'package:http/http.dart' as http;

class BuyOrNotApi {
  static Future getEvaluationLists() async {
    final response = await http.get(
      Uri.parse("$stockApiUrl/api/buyornot"),
      headers: <String, String> {
        'Content-Type': 'application/json',
        //'Authorization': token,
      },
    );
    print('[GET] /api/buyornot');
    print(response.statusCode);
    if(response.statusCode == 200) {
      final resposeBody = json.decode(utf8.decode(response.bodyBytes));
      return resposeBody;
    }
    throw Exception(response.statusCode.toString()+":"+response.body.toString());
  }
}