import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api.dart';

class CalculatorApi{
  static Future getResult() async {
    print('uri');
    print("$stockApiUrl/api/buythen/calculate");

  //   final response = await http.get(
  //     Uri.parse("$stockApiUrl/api/buythen"),
  //     headers: <String, String> {
  //       'Content-Type': 'application/json',
  //       //'Authorization': token,
  //     },
  //   );
  //   if(response.statusCode == 200) {
  //     final resposeBody = json.decode(response.body);
  //     return resposeBody['data'];
  //   }
  //   throw Exception(response.statusCode.toString()+":"+response.body.toString());
  }

  static Future getCompanies() async {
      final response = await http.get(
        Uri.parse("$stockApiUrl/api/buythen"),
        headers: <String, String> {
          'Content-Type': 'application/json',
          //'Authorization': token,
        },
      );
      print('[GET] /api/buythen');
      print(response.statusCode);
      if(response.statusCode == 200) {
        final resposeBody = json.decode(utf8.decode(response.bodyBytes));
        return resposeBody;
      }
      throw Exception(response.statusCode.toString()+":"+response.body.toString());
  }
}