import 'package:flutter/material.dart';
import 'package:should_have_bought_app/models/chart/sample_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class ChartWidget extends StatefulWidget {
  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {

  TrackballBehavior _trackballBehavior;
  @override
  void initState() {
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildVerticalGradientAreaChart();
  }

  /// Returns the list of spline area series with vertical gradient.
  List<ChartSeries<_ChartData, String>> _getGradientAreaSeries() {
    final List<_ChartData> chartData = <_ChartData>[
      _ChartData(x: '1997', y: 22.44),
      _ChartData(x: '1998', y: 25.18),
      _ChartData(x: '1999', y: 24.15),
      _ChartData(x: '2000', y: 25.83),
      _ChartData(x: '2001', y: 25.69),
      _ChartData(x: '2002', y: 24.75),
      _ChartData(x: '2003', y: 27.38),
      _ChartData(x: '2004', y: 25.31)
    ];
    final List<Color> color = <Color>[];
    color.add(const Color(0xFF6A31D5));
    color.add(const Color(0xFFB650C8));

    final List<double> stops = <double>[];
    stops.add(0.1);
    stops.add(0.4);

    return <ChartSeries<_ChartData, String>>[
      SplineAreaSeries<_ChartData, String>(
        /// To set the gradient colors for series.
          gradient: const LinearGradient(colors: <Color>[
            Color.fromRGBO(269, 210, 255, 1),
            Color.fromRGBO(143, 236, 154, 1)
          ], stops: <double>[
            0.2,
            0.6
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          borderWidth: 2,
          //borderColor: const Color.fromRGBO(0, 156, 144, 1),
          borderDrawMode: BorderDrawMode.top,
          dataSource: chartData,
          name: 'Country 1',
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y),
      // SplineAreaSeries<_ChartData, String>(
      //     gradient: const LinearGradient(colors: <Color>[
      //       Color.fromRGBO(140, 108, 245, 1),
      //       Color.fromRGBO(125, 185, 253, 1)
      //     ], stops: <double>[
      //       0.3,
      //       0.7
      //     ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
      //     borderWidth: 2,
      //     name: 'Country 2',
      //     borderColor: const Color.fromRGBO(0, 63, 136, 1),
      //     borderDrawMode: BorderDrawMode.top,
      //     dataSource: <_ChartData>[
      //       _ChartData(x: '1997', y: 17.5),
      //       _ChartData(x: '1998', y: 21.5),
      //       _ChartData(x: '1999', y: 19.5),
      //       _ChartData(x: '2000', y: 22.5),
      //       _ChartData(x: '2001', y: 21.5),
      //       _ChartData(x: '2002', y: 20.5),
      //       _ChartData(x: '2003', y: 23.5),
      //       _ChartData(x: '2004', y: 19.5)
      //     ],
      //     xValueMapper: (_ChartData sales, _) => sales.x,
      //     yValueMapper: (_ChartData sales, _) => sales.y)
    ];
  }

  /// Return the circular chart with vertical gradient.
  SfCartesianChart _buildVerticalGradientAreaChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        isVisible: false,
          labelPlacement: LabelPlacement.onTicks,
          interval: null,
          labelRotation: -45,
          majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
        isVisible: false,
        minimum: 0,
        maximum: 28,
        interval: 4,
        labelFormat: '{value}%',
        axisLine: AxisLine(width: 0),
      ),
      //trackballBehavior: _trackballBehavior,
      series: _getGradientAreaSeries(),
    );
  }
}

class _ChartData {
  _ChartData({this.x, this.y});
  final String x;
  final double y;
}