import 'package:intl/intl.dart';

String numberWithComma(String value) {
  return NumberFormat('###,###,###,###')
      .format(double.parse(value))
      .replaceAll(' ', '');
}

int intToCurrency(String value) {
  return int.parse(value.replaceAll(',', ''));
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
