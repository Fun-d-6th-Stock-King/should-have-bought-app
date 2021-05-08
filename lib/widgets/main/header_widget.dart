import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';

class HeaderWidget extends StatefulWidget {
  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget>  {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    print("_auth:");
    print(_auth.currentUser);
    return Wrap(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _auth.currentUser != null ?
                Row(
                  children: [
                    Text("${_auth.currentUser.displayName}",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                          color: mainColor,
                        )),
                    Text(" 님,",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            height: 1.5)),
                  ],
                ) : Row(),
                Text("오늘도 익절하는 하루 되세요.",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500, height: 1.5)
                ),
              ],
            ),
            Image(image: AssetImage('assets/icons/ico_default_profile.png')),
          ],
        ),

      ],
    );
  }
}
