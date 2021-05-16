import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BuyOrNotChartWidget extends StatefulWidget {


  @override
  _BuyOrNotChartWidgetState createState() => _BuyOrNotChartWidgetState();
}

/// State class of horizontal gradient.
class _BuyOrNotChartWidgetState extends State<BuyOrNotChartWidget> {

  @override
  void initState() {
   // _tooltipBehavior = TooltipBehavior(enable: true, canShowMarker: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildHorizantalGradientAreaChart();
  }

  /// Return the circular chart with horizontal gradient.
  SfCartesianChart _buildHorizantalGradientAreaChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        isVisible: false,
          labelPlacement: LabelPlacement.onTicks,
          interval: null,
          labelRotation: -45,
          majorGridLines: MajorGridLines(width: 0)),
      tooltipBehavior: null,
      primaryYAxis: NumericAxis(
          isVisible: false,
          interval: null,
          minimum: 14,
          maximum: 20,
          labelFormat: '{value}%',
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(size: 0)),
      series: _getGradientAreaSeries(),
      onMarkerRender: (MarkerRenderArgs args) {
        if (args.pointIndex == 0) {
          args.color = const Color.fromRGBO(207, 124, 168, 1);
        } else if (args.pointIndex == 1) {
          args.color = const Color.fromRGBO(210, 133, 167, 1);
        } else if (args.pointIndex == 2) {
          args.color = const Color.fromRGBO(219, 128, 161, 1);
        } else if (args.pointIndex == 3) {
          args.color = const Color.fromRGBO(213, 143, 151, 1);
        } else if (args.pointIndex == 4) {
          args.color = const Color.fromRGBO(226, 157, 126, 1);
        } else if (args.pointIndex == 5) {
          args.color = const Color.fromRGBO(220, 169, 122, 1);
        } else if (args.pointIndex == 6) {
          args.color = const Color.fromRGBO(221, 176, 108, 1);
        } else if (args.pointIndex == 7) {
          args.color = const Color.fromRGBO(222, 187, 97, 1);
        }
      },
    );
  }

  /// Returns the list of spline area series with horizontal gradient.
  List<ChartSeries<_ChartData, String>> _getGradientAreaSeries() {
    final List<_ChartData> chartData = <_ChartData>[
      _ChartData(x: '1997', y: 17.70),
      _ChartData(x: '1998', y: 18.20),
      _ChartData(x: '1999', y: 18),
      _ChartData(x: '2000', y: 19),
      _ChartData(x: '2001', y: 18.5),
      _ChartData(x: '2002', y: 18),
      _ChartData(x: '2003', y: 18.80),
      _ChartData(x: '2004', y: 17.90)
    ];
    final List<Color> color = <Color>[];
    color.add(Colors.blue[200]);
    color.add(Colors.orange[200]);

    final List<double> stops = <double>[];
    stops.add(0.2);
    stops.add(0.7);

    return <ChartSeries<_ChartData, String>>[
      SplineAreaSeries<_ChartData, String>(
          gradient: const LinearGradient(colors: <Color>[
            Color.fromRGBO(255, 184, 0, 0.468),
            Color.fromRGBO(255, 184, 0, 0)
          ], stops: <double>[
            0.1,
            0.9
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          borderWidth: 2,
          borderColor: mainColor,
          borderDrawMode: BorderDrawMode.top,
          dataSource: chartData,
          name: 'Country 1',
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y),
    ];
  }
}

class _ChartData {
  _ChartData({this.x, this.y});
  final String x;
  final double y;
}