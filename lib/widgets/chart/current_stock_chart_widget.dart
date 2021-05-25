import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:should_have_bought_app/models/calculator/current_stock_price.dart';

class CurrentStockChartWidget extends StatefulWidget {
  final String type;
  final CurrentStockPrice value;
  CurrentStockChartWidget({@required this.type, @required this.value});

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
    return _buildVerticalGradientAreaChart(widget.value);
  }

  /// Returns the list of spline area series with vertical gradient.
  List<LineSeries<_ChartData, num>> _getDataLabelDefaultSeries(CurrentStockPrice value) {
    final List<_ChartData> dayData = <_ChartData>[
    ];
    final List<_ChartData> weekData = <_ChartData>[
    ];
    final List<_ChartData> yearData = <_ChartData>[
    ];
    final List<Color> color = <Color>[];

    color.add(const Color(0xFFFF6258));

    dayData.add(_ChartData(1, value.dayLow));
    dayData.add(_ChartData(9, value.dayHigh));
    weekData.add(_ChartData(1, value.weekHigh));
    weekData.add( _ChartData(9, value.weekLow));
    yearData.add(_ChartData(1, value.yearLow));
    yearData.add( _ChartData(9, value.yearHigh));
    LineSeries<_ChartData, num> daliy() {
      return LineSeries<_ChartData, num>(
          animationDuration: 2500,
          legendIconType: LegendIconType.circle,
          dataSource: dayData,
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
          ));
    }
    LineSeries<_ChartData, num> weekly() {

      return LineSeries<_ChartData, num>(
          animationDuration: 2500,
          legendIconType: LegendIconType.circle,
          dataSource: weekData,
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
          ));
    }
    LineSeries<_ChartData, num> yearly() {

      return LineSeries<_ChartData, num>(
          animationDuration: 2500,
          legendIconType: LegendIconType.circle,
          dataSource: yearData,
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
          ));
    }
    if (widget.type == '장중') {return <LineSeries<_ChartData, num>> [daliy()];}
    if (widget.type == '주간') {return <LineSeries<_ChartData, num>> [weekly()];}
    if (widget.type == '연간') {return <LineSeries<_ChartData, num>> [yearly()];}

    return <LineSeries<_ChartData, num>>[
      daliy(),
      weekly(),
      yearly()
    ];
  }

  /// Return the circular chart with vertical gradient.
  SfCartesianChart _buildVerticalGradientAreaChart(CurrentStockPrice value) {
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
      series: _getDataLabelDefaultSeries(value),
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
  _ChartData(this.x, this.y);

  final double x;
  final double y;
}

