//import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, AuthResult, GoogleAuthProvider;
//import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart' show GoogleSignIn;
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget  {

  LoginScreen();
  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

//  bool _isKakaoTalkInstalled = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
//    _initKakaoTalkInstalled();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  // _initKakaoTalkInstalled() async {
  //   final installed = await isKakaoTalkInstalled();
  //   print('kakao Install : ' + installed.toString());
  //
  //   setState(() {
  //     _isKakaoTalkInstalled = installed;
  //   });
  // }
  //
  // _issueAccessToken(String authCode) async {
  //   try {
  //     var token = await AuthApi.instance.issueAccessToken(authCode);
  //     AccessTokenStore.instance.toStore(token);
  //     String kakaoToken = token.toJson()['access_token'];
  //     final data = {'token':kakaoToken};
  //     print('kakaoToken:'+kakaoToken);
  //     Map customToken = await FirebaseKakaoApi.verifyToken(data);
  //
  //     UserCredential userCredential = (await _auth.signInWithCustomToken(customToken['firebase_token']));
  //     User user = userCredential.user;
  //
  //     return user;
  //     //Navigator.pushNamed(context, '/main');
  //   } catch (e) {
  //     print("error on issuing access token: $e");
  //   }
  // }

  // _loginWithTalk() async {
  //   try {
  //     var code = await AuthCodeClient.instance.requestWithTalk();
  //     await _issueAccessToken(code);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  //
  // _loginWithKakao() async {
  //   try {
  //     var code = await AuthCodeClient.instance.request();
  //     await _issueAccessToken(code);
  //   } catch (e) {
  //     print(e);
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f6f7),
      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding:EdgeInsets.only(bottom: 100)),
                    Padding(padding:EdgeInsets.only(bottom: 56)),
                    ButtonTheme(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          side: BorderSide(color:Colors.black)
                      ),
                      child: ElevatedButton(
                          child: SizedBox(
                            width: 270,
                            height: 46,
                            child: Row(
                                children: <Widget>[
                                  //Image(image: AssetImage('assets/icons/ico_kakaologin.png')),
                                  SizedBox(
                                      width:63
                                  ),
                                  Expanded(
                                      flex:2,
                                      child: Text("카카오로 로그인", style: TextStyle(fontSize: 12.0, height: 1.571))
                                  )
                                ]),
                          ), onPressed: () {  },
                          //onPressed: _isKakaoTalkInstalled ? _loginWithTalk : _loginWithKakao
                      ),
                    ),
                    Padding(padding:EdgeInsets.only(bottom: 9)),
                    ButtonTheme(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          side: BorderSide(color:Colors.black)
                      ),
                      child: ElevatedButton(
                          child: SizedBox(
                            width: 270,
                            height: 46,
                            child: Row(
                                children: <Widget>[
                                  //Image(image: AssetImage('assets/icons/ico_google.png')),
                                  SizedBox(
                                      width:70
                                  ),
                                  Expanded(
                                      flex:2,
                                      child: Text('구글로 로그인', style: TextStyle(fontSize: 12.0, height: 1.571))
                                  )
                                ]),
                          ),
                          style: ButtonStyle(
                            // backgroundColor: MaterialStateProperty.all<Color>(Color(0xfff5f6f7)),
                            elevation: MaterialStateProperty.all<double>(0.0)
                          ),
                          onPressed: () {
                            _handleGoogleSignIn();
                          }
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 22)),
                Padding(padding:EdgeInsets.only(bottom: 42)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // google login 수행하고 FirebaseUser 반환
  Future<User> _handleGoogleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // 구글 로그인으로 인증된 정보를 기반으로 FirebaseUser 객체 구성
    User user = (await _auth.signInWithCredential(
        GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken))).user;

    return user;
  }
}