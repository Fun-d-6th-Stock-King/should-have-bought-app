import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final stockApiUrl = env['STOCK_API'];

class Api {
  static Future<String> getToken() async{
    final user = await FirebaseAuth.instance.currentUser;
    print('[getToken]');
    if (user != null) {
      final idToken = await user.getIdToken().then((value) => value);
      return idToken;
    }
    return "";
  }

  static Future<Map<String, String>> getHeader() async {
    String token = await getToken();
    print('token: $token');
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$token',
    };
  }
}