import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
    return ElevatedButton(
        child: SizedBox(
          width: 270,
          height: 40,
          child: Row(children: <Widget>[
            Image(image: AssetImage('assets/icons/ico_google.png')),
            SizedBox(width: 24),
            Expanded(
                flex: 2,
                child: Text('Sign in with Google',
                    style: TextStyle(color: Colors.grey, fontSize: 14.0, height: 1.571)))
          ]),
        ),
        style: ElevatedButton.styleFrom(
          primary: Color(0xFFFFFFFF),
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
          _handleGoogleSignIn().then((_) {
            widget.onPressed == null ? "" : widget.onPressed();
            EasyLoading.dismiss();
          });
        });
  }

  Future<User> _handleGoogleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // 구글 로그인으로 인증된 정보를 기반으로 FirebaseUser 객체 구성
    User user = (await _auth.signInWithCredential(GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken)))
        .user;

    //TODO: UPDATE FLOW 필요
    //user.updateProfile(displayName: 'test');
    return user;
  }
}
