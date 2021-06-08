import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/screens/my_page/edit_profile_bottom_sheet.dart';

Widget MyPageAppbar(BuildContext context) {
  return AppBar(
    title: Text('마이페이지'),
    centerTitle: true,
    backgroundColor: defaultBackgroundColor,
    leading: null,
    elevation: 0,
  );
}
