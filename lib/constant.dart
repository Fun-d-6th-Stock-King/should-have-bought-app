import 'package:flutter/material.dart';

const mainColor = Color(0xFFFF9900);
const defaultBackgroundColor = Color(0xFFFFFFFF);
const defaultFontColor = Color(0xFFFFFFFF);

const backgroundColor = Color(0xFFF4F4F4);
const possibleColor = Color(0xFFFF8888);
const nagativeColor = Color(0xFF5D99F2);
const likeColor = Color(0xFFFF3948);
const unlikeColor = Color(0xFF4990FF);
const disableColor = Color(0xFFBDBDBD);
const kDateColor = Color(0xFF828282);
const kGreyColor = Color(0xFFE0E0E0);

Map<String, String> dateValue = {
  'DAY1': '어제',
  'WEEK1': '저번주',
  'MONTH1': '한달 전',
  'MONTH6': '6개월 전',
  'YEAR1': '1년 전',
  'YEAR5': '5년 전',
  'YEAR10': '10년 전'
};

Map<String, String> reverseDateValue = {
  '어제': 'DAY1',
  '1주전': 'WEEK1',
  '한달전': 'MONTH1',
  '6개월전': 'MONTH6',
  '1년전': 'YEAR1',
  '5년전': 'YEAR5',
  '10년전': 'YEAR10'
};

List<String> dates = [
  'DAY1',
  'WEEK1',
  'MONTH1',
  'MONTH6',
  'YEAR1',
  'YEAR5',
  'YEAR10'
];

List<String> prices = ['100000', '500000', '1000000', '5000000', '10000000'];

const kSalaryTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w400,
);

const kMainBoldTextStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
);

const kOldStockTextStyle = TextStyle(
  fontWeight: FontWeight.w700,
);

const kCardTitleTextStyle = TextStyle(
  fontSize: 24,
  height: 35 / 24,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
const kCardContentTextStyle = TextStyle(
    fontSize: 16,
    height: 20 / 16,
    fontWeight: FontWeight.w400,
    color: Colors.black);

const buyOrNotCountTextStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 15,
  height: 18 / 15,
  color: Color(0xFF4F4F4F),
);

const dateStyle = TextStyle(
  fontSize: 11,
  height: 13 / 11,
  color: Color(0XFFBDBDBD),
);

const stockDateStyle = TextStyle(
  fontSize: 11,
  height: 13 / 11,
  color: Color(0xFF828282),
);

const stockTitleStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 22, height: 32 / 22);

const stockBodyStyle = TextStyle(
  fontSize: 14,
  height: 20 / 14,
);

const stockBodyNumberStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 21,
  height: 25 / 21,
);

const kResultTitleStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w700,
);
