import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';

Widget CardAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Color(0xFFFFFFFF),
    automaticallyImplyLeading:false,
    leading: null,
    elevation: 0,
    centerTitle: true,
    title: Container(
      width: 300,
      child: DefaultTextStyle(
        style : TextStyle(
          color: Colors.black,
          fontSize: 17,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children :[
            Text('μ΄ μ’λͺ©'),
            Text(' πΎοΈ μ΄λ? β λ§λ?', style: TextStyle(
              fontWeight: FontWeight.w700
            ),)
        ],),
      ),
    ),
  );
}
