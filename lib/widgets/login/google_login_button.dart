import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginButton extends StatefulWidget {
  final VoidCallback onPressed;

  GoogleLoginButton({@required this.onPressed});

  @override
  _GoogleLoginButtonState createState() => _GoogleLoginButtonState();
}

class _GoogleLoginButtonState extends State<GoogleLoginButton> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
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
              widget.onPressed !=null ? widget.onPressed(): "";
            });
          }),
    );
  }

  Future<User> _handleGoogleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // 구글 로그인으로 인증된 정보를 기반으로 FirebaseUser 객체 구성
    User user = (await _auth.signInWithCredential(GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken)))
        .user;

    user.updateProfile(displayName: 'test');
    return user;
  }
}
