import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:kakao_flutter_sdk/common.dart';
import 'package:should_have_bought_app/api/login/firebase_kakao_api.dart';
import 'package:should_have_bought_app/widgets/util/loading/loading_widget.dart';

class KakaoLoginButton extends StatefulWidget {
  final VoidCallback onPressed;

  KakaoLoginButton({@required this.onPressed});

  @override
  _KakaoLoginButtonState createState() => _KakaoLoginButtonState();
}

class _KakaoLoginButtonState extends State<KakaoLoginButton> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isKakaoTalkInstalled = false;

  @override
  void initState() {
    super.initState();
    _initKakaoTalkInstalled();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: SizedBox(
          width: 270,
          height: 40,
          child: Row(children: <Widget>[
            Image(image: AssetImage('assets/icons/ico_kakao.png')),
            SizedBox(width: 14),
            Expanded(
                flex: 2,
                child: Text('카카오로 로그인',
                    style: TextStyle(fontSize: 14.0, height: 1.571, color:Colors.black, fontWeight: FontWeight.bold)))
          ]),
        ),
        style: ElevatedButton.styleFrom(
            primary: Color(0xFFFFE600),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0), //side: BorderSide(color: Colors.red)
            ),
        ),
        onPressed: () async {
          await EasyLoading.show(
            status: 'loading...',
            maskType: EasyLoadingMaskType.black,
          );
          _isKakaoTalkInstalled
              ? _loginWithApp().then((_) {
                  widget.onPressed == null ? "" : widget.onPressed();
                  EasyLoading.dismiss();
                })
              : _loginWithWeb().then((_) {
                  widget.onPressed == null ? "" : widget.onPressed();
                  EasyLoading.dismiss();
                });
        });
  }

  _initKakaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    print('kakao Install : ' + installed.toString());

    setState(() {
      _isKakaoTalkInstalled = installed;
    });
  }

  _loginWithApp() async {
    try {
      var code = await AuthCodeClient.instance.requestWithTalk();
      await _getAccessToken(code);
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("$e")));
    }
  }

  _loginWithWeb() async {
    try {
      var code = await AuthCodeClient.instance.request();
      await _getAccessToken(code);
    } catch (e) {
    }
  }

  _getAccessToken(String authCode) async {
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(token);
      String kakaoToken = token.toJson()['access_token'];
      final data = {'token': kakaoToken};
      print('kakaoToken:' + kakaoToken);
      Map customToken = await FirebaseKakaoApi.verifyToken(data);

      UserCredential userCredential =
          (await _auth.signInWithCustomToken(customToken['firebase_token']));
      User user = userCredential.user;

      return user;
      //Navigator.pushNamed(context, '/main');
    } catch (e) {
      print("error on issuing access token: $e");
    }
  }
}

