import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

String numberWithComma(String value) {
  if(value == '') return '0';
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
  if(date == '') return '';
  return DateFormat('y.MM.d.h:m').format(DateTime.parse(date));
}

String commonDayDateFormat(String date) {
  if(date == '') return '';
  return DateFormat('y.MM.d.').format(DateTime.parse(date));
}

bool isNotLogin(User currentUser) {
  return currentUser == null ? true : false;
}