import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';

Widget DripRoomAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: mainColor,
    leading: null,
    centerTitle: true,
    title: Text(
      '드립방',
      style: TextStyle(color: Colors.white),
    ),
    elevation: 0,
    actions: <Widget>[
      IconButton(
          icon: Image(image: AssetImage('assets/icons/search.png')),
          onPressed: null),
    ],
  );
}
