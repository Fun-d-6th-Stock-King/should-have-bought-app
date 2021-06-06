import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/screens/main/main_screen.dart';
import 'package:should_have_bought_app/widgets/appbar/mypage_appbar.dart';

class MyPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: MyPageAppbar(context),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(height: 35),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(150.0),
                border: Border.all(
                  color: mainColor,
                  width: 3.0,
                ),
              ),
              child: CircleAvatar(
                backgroundColor: defaultBackgroundColor,
                child:
                    Image(image: AssetImage('assets/images/normal_chick.png')),
              ),
            ),
            SizedBox(height: 12),
            Text(
              '안녕하세요!',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.w300,
                ),
                children: [
                  TextSpan(
                    text: '홍길동',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: mainColor,
                    ),
                  ),
                  TextSpan(text: '님'),
                ],
              ),
            ),
            SizedBox(height: 60),
            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: mainColor,
              ),
              child: Center(
                child: Text(
                  '가이드',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 19,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    print('로그아웃');
                    logOutDialog(context).then((value) {
                      if (value) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => MainScreen()),
                          (Route<dynamic> route) => false,
                        );
                      }
                      return null;
                    });
                  },
                  child: Text(
                    '로그아웃',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  height: 15,
                  child: VerticalDivider(
                    width: 1,
                  ),
                  color: Color(0xFF898A8D).withOpacity(0.10),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    '팀원소개',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future logOutDialog(BuildContext context) async {
    bool _isLogout = false;
    await showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return Container(
            child: AlertDialog(
              contentPadding: EdgeInsets.all(0.0),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              title: Container(
                  width: 400,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 4.0),
                  child: Text('정말 로그아웃 하시겠어요?')),
              content: Wrap(
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                  ),
                  Center(child: Text('bye!')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(""),
                    ],
                  ),
                  SizedBox(
                    width: 16,
                    height: 20,
                  ),
                  Divider(height: 2.0, thickness: 1.0, color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Container(
                            padding: EdgeInsets.only(
                                top: 16, bottom: 20, left: 54, right: 54),
                            child: Text("취소", style: TextStyle(height: 1.5))),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text("|", style: TextStyle(height: 1.5)),
                      InkWell(
                        onTap: () {
                          logout().then((_) => Navigator.pop(context, true));
                        },
                        child: Container(
                            padding: EdgeInsets.only(
                                top: 16, bottom: 20, left: 54, right: 54),
                            child: Text("확인", style: TextStyle(height: 1.5))),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
    return _isLogout;
  }

  Future logout() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    _firebaseAuth.signOut();
  }
}
