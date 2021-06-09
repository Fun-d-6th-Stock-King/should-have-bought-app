import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/screens/main/search_screen.dart';

Widget DefaultAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: defaultBackgroundColor,
    leading: null,
    elevation: 0,
    actions: <Widget>[
      IconButton(
          icon: Image(image: AssetImage('assets/icons/ico_search.png')),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
          },)
    ],
  );
}
