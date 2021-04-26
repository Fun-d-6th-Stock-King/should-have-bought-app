import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:should_have_bought_app/screens.dart';

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
          ButtonTheme(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  side: BorderSide(color: Colors.black)),
              child: ElevatedButton(
                  child: SizedBox(
                    width: 270,
                    height: 46,
                    child: Row(children: <Widget>[
                      //Image(image: AssetImage('assets/icons/ico_google.png')),
                      SizedBox(width: 70),
                      Expanded(
                          flex: 2,
                          child: Text('구글로 로그인',
                              style: TextStyle(fontSize: 12.0, height: 1.571)))
                    ]),
                  ),
                  style: ButtonStyle(
                    // backgroundColor: MaterialStateProperty.all<Color>(Color(0xfff5f6f7)),
                      elevation: MaterialStateProperty.all<double>(0.0)),
                  onPressed: () {
                    _handleGoogleSignIn().then((value) {
                      print(_auth);
                      Navigator.pop(context);
                    });
                  }
              )
          )
        ],
      ),
    );
  }

  
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
