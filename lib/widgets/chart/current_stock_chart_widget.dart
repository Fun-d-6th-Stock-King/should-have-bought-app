import 'package:flutter/material.dart';
import 'package:should_have_bought_app/models/chart/sample_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class CurrentStockChartWidget extends StatefulWidget {
  @override
  _CurrentStockChartWidgetState createState() =>
      _CurrentStockChartWidgetState();
}

class _CurrentStockChartWidgetState extends State<CurrentStockChartWidget> {
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
  List<LineSeries<_ChartData, num>> _getDataLabelDefaultSeries() {
    final List<_ChartData> chartData = <_ChartData>[
      _ChartData(1, 50, 28),
      _ChartData(9, 55, 84)
    ];
    final List<_ChartData> chartData1 = <_ChartData>[
      _ChartData(1, 100, 100),
      _ChartData(9, 30, 30),
    ];
    final List<_ChartData> chartData2 = <_ChartData>[
      _ChartData(1, 0, 70),
      _ChartData(9, 70, 84)
    ];
    final List<Color> color = <Color>[];
    color.add(const Color(0xFFFF6258));

    final List<double> stops = <double>[];
    stops.add(0.1);
    stops.add(0.4);

    return <LineSeries<_ChartData, num>>[
      LineSeries<_ChartData, num>(
          animationDuration: 0,
          legendIconType: LegendIconType.circle,
          dataSource: chartData,
          color: const Color(0xFF4990FF),
          width: 2,
          name: '장중',
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          markerSettings: MarkerSettings(
            isVisible: true,
            width: 6,
            height: 6,
            color: Color(0xFF4990FF),
          ),
          dataLabelSettings: DataLabelSettings(
            isVisible: false,
            useSeriesColor: false,
            alignment: ChartAlignment.center,
            labelAlignment: ChartDataLabelAlignment.top,
            offset: Offset(0, 0),
          )),
      LineSeries<_ChartData, num>(
          animationDuration: 0,
          legendIconType: LegendIconType.circle,
          dataSource: chartData1,
          color: Color(0xFFFF6258),
          width: 2,
          name: '주간',
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          markerSettings: MarkerSettings(
            isVisible: true,
            width: 6,
            height: 6,
            color: Color(0xFFFF6258),
          ),
          dataLabelSettings: DataLabelSettings(
            isVisible: false,
            useSeriesColor: false,
            alignment: ChartAlignment.center,
            labelAlignment: ChartDataLabelAlignment.top,
            offset: Offset(0, 0),
          )),
      LineSeries<_ChartData, num>(
          animationDuration: 0,
          legendIconType: LegendIconType.circle,
          dataSource: chartData2,
          color: Color(0xFFFF9900),
          width: 2,
          name: '연간',
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          markerSettings: MarkerSettings(
            isVisible: true,
            width: 6,
            height: 6,
            color: Color(0xFFFF9900),
          ),
          dataLabelSettings: DataLabelSettings(
            isVisible: false,
            useSeriesColor: false,
            alignment: ChartAlignment.center,
            labelAlignment: ChartDataLabelAlignment.top,
            offset: Offset(0, 0),
          )),
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
          majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
        isVisible: false,
        interval: null,
        minimum: 0,
        maximum: 100,
        labelFormat: '{value}',
        axisLine: AxisLine(width: 0),
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      legend: Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.none,
        alignment: ChartAlignment.far,
        position: LegendPosition.bottom,
        iconWidth: 6,
        iconHeight: 6,
        itemPadding: 6,
        padding: 3,
        textStyle: TextStyle(color: Color(0xFF979797), fontSize: 10,)
      ),
      // onDataLabelRender: (DataLabelRenderArgs args) {
      //   dataLabel(args);
      // },
      //trackballBehavior: _trackballBehavior,
      series: _getDataLabelDefaultSeries(),
    );
  }
}

// void dataLabel(DataLabelRenderArgs args) {
//   if(args.pointIndex == 0) {
//     args.textStyle = TextStyle(color:Color(0xFF5D99F2), fontWeight: FontWeight.bold);
//     args.offset = Offset(0,-30);
//     args.text = "최저 ${args.text}";
//   }
//   else if (args.pointIndex == args.dataPoints.length-1) {
//     args.textStyle = TextStyle(color:Color(0xFFFF6258), fontWeight: FontWeight.bold);
//     args.offset = Offset(0,30);
//     args.text = "최고 ${args.text}";
//   } else {
//     args.text = "";
//   }
// }
class _ChartData {
  _ChartData(this.x, this.y, this.y2);

  final double x;
  final double y;
  final double y2;
}
