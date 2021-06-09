import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:should_have_bought_app/constant.dart';

String numberWithComma(String value) {
  if (value == '') return '0';
  return NumberFormat('###,###,###,###')
      .format(double.parse(value))
      .replaceAll(' ', '');
}

int intToCurrency(String value) {
  return int.parse(value.replaceAll(',', ''));
}

String convertMoney(String investMoney) {
  int dividedMoney;
  String totalResultString;
  String hundredMilion;
  String tenMilion;
  String thousand;

  dividedMoney = (int.parse(investMoney) ~/ 10000);

  // 일억 이상인경우
  if (dividedMoney >= 10000) {
    hundredMilion = (dividedMoney ~/ 10000).toStringAsFixed(0);
    tenMilion = (dividedMoney % 10000).toString();
    totalResultString = '$hundredMilion억 $tenMilion만';
  }
  // 만원 미만인 경우
  else if (dividedMoney == 0) {
    thousand = (int.parse(investMoney) ~/ 1000).toStringAsFixed(0);
    totalResultString = '$thousand천';
  }
  // 만원 이상인 경우
  else {
    tenMilion = dividedMoney.toString();
    totalResultString = '$tenMilion만';
  }

  return totalResultString;
}

String convertMinuteToHours(String date) {
  int minutes;
  int hours;
  minutes = DateTime.now().difference(DateTime.parse(date)).inMinutes;
  hours = minutes ~/ 60;
  if (hours >= 1) {
    return '$hours시간 전';
  } else {
    return '$minutes분 전';
  }
}

String convertKorDateFormat(String date) {
  return DateFormat('y년 MM월 d일').format(DateTime.parse(date));
}

String commonDateFormat(String date) {
  if (date == '') return '';
  return DateFormat('y.MM.d.h:m').format(DateTime.parse(date));
}

String commonDayDateFormat(String date) {
  if (date == '') return '';
  return DateFormat('y.MM.d.').format(DateTime.parse(date));
}

String commonTwoDayDateFormat(String date) {
  if (date == '') return '';
  return DateFormat('y.MM.dd').format(DateTime.parse(date));
}

bool isNotLogin(User currentUser) {
  return currentUser == null ? true : false;
}

String checkIncreaseOrDecrease(double percent) {
  if (percent > 0) return '+';
  return '';
}

Color colorIncreaseOrDecrease(double percent) {
  if (percent > 0) return possibleColor;
  if (percent < 0) return nagativeColor;
  return Colors.black;
}

class Frame extends StatelessWidget {
  final Widget child;
  Frame({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16), child: child);
  }
}

String emojiIncreaseOrDecrease(double percent) {
  if (percent > 0) return "▲ ";
  if (percent < 0) return "▼ ";
  return "- ";
}

List<TextSpan> highlightOccurrences(String source, String query) {
  if (query == null || query.isEmpty || !source.toLowerCase().contains(query.toLowerCase())) {
    return [ TextSpan(text: source) ];
  }
  final matches = query.toLowerCase().allMatches(source.toLowerCase());

  int lastMatchEnd = 0;

  final List<TextSpan> children = [];
  for (var i = 0; i < matches.length; i++) {
    final match = matches.elementAt(i);

    if (match.start != lastMatchEnd) {
      children.add(TextSpan(
        text: source.substring(lastMatchEnd, match.start),
      ));
    }

    children.add(TextSpan(
      text: source.substring(match.start, match.end),
      style: TextStyle(color:mainColor),
    ));

    if (i == matches.length - 1 && match.end != source.length) {
      children.add(TextSpan(
        text: source.substring(match.end, source.length),
      ));
    }

    lastMatchEnd = match.end;
  }
  return children;
}