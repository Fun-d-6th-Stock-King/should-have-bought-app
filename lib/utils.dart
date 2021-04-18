import 'package:intl/intl.dart';

String numberWithComma(String value){
  return NumberFormat('###,###,###,###').format(double.parse(value)).replaceAll(' ', '');
}

int intToCurrency(String value) {
  return int.parse(value.replaceAll(',', ''));
}