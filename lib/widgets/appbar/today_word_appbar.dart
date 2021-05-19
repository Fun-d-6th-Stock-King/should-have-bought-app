import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';

Widget TodayWordAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: mainColor,
    leading: null,
    centerTitle: true,
    title: Text(
      '오늘의 단어',
      style: TextStyle(color: Colors.white),
    ),
    elevation: 0,
    actions: <Widget>[
      IconButton(
          icon: Image(image: AssetImage('assets/icons/ico_search_white.png')),
          onPressed: null),
    ],
  );
}
