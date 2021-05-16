import 'package:flutter/material.dart';

class BuyOrNotChart {
  final String symbol;
  final String date;
  final double open;
  final double low;
  final double high;
  final double close;
  final double adjClose;
  final int volume;

  BuyOrNotChart(
      {@required this.symbol,
      @required this.date,
      @required this.open,
      @required this.low,
      @required this.high,
      @required this.close,
      @required this.adjClose,
      @required this.volume});

  factory BuyOrNotChart.fromJson(dynamic json) {
    return BuyOrNotChart(
      symbol: json['symbol'] ?? '',
      date: json['date'] ?? '',
      open: json['open'] ?? 0,
      low: json['low'] ?? 0,
      high: json['high'] ?? 0,
      close: json['close'] ?? 0,
      adjClose: json['adjClose'] ?? 0,
      volume: json['volume'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'symbol': symbol,
      'date': date,
      'open': open,
      'low': low,
      'high': high,
      'close': close,
      'adjClose': adjClose,
      'volume': volume,
    };
  }
}
