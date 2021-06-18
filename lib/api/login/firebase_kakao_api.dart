import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api.dart';

class FirebaseKakaoApi extends Api {
  static Future verifyToken(Map data) async {
    final response = await http.post(
      Uri.parse("$firebaseFunctionApi/verifyToken"),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      final resposeBody = json.decode(response.body);
      print('[verifyToken] response:');
      print(resposeBody);
      return resposeBody;
    } else {
      throw Exception(
          '${response.statusCode.toString()} : ${utf8.decode(response.bodyBytes)}');
    }
  }
}
