import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:should_have_bought_app/screens.dart';
import 'package:should_have_bought_app/widgets/login/google_login_button.dart';
import 'package:should_have_bought_app/widgets/login/kakao_login_button.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginWidget> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
//    _initKakaoTalkInstalled();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GoogleLoginButton(onPressed: () {
            Navigator.pop(context);
          }),
          KakaoLoginButton(onPressed: () {
            Navigator.pop(context);
          }),
        ],
      ),
    );
  }
}
