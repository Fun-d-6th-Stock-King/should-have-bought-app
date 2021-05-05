import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';

Widget CardAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Color(0xFFFFFFFF),
    leading: null,
    elevation: 0,
    centerTitle: true,
    title: DefaultTextStyle(
      style : TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children :[
          Text('이 종목'),
          Text(' 🅾️ 살래? ❎ 말래?', style: TextStyle(
            fontWeight: FontWeight.w700
          ),)
      ],),
    ),
  );
}
