import 'package:flutter/material.dart';

const mainColor = Color(0xFFFFB800);
const defaultBackgroundColor = Color(0xFFFFFFFF);
const defaultFontColor = Color(0xFFFFFFFF);

Map<String, String> dateValue = {
  'DAY1': '어제',
  'WEEK1': '저번주',
  'MONTH1': '한달 전',
  'MONTH6': '6개월 전',
  'YEAR1': '1년 전',
  'YEAR5': '5년 전',
  'YEAR10': '10년 전'
};

const kSalaryTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w400,
);

const kMainBoldTextStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
);

const kOldStockTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w700,
);
