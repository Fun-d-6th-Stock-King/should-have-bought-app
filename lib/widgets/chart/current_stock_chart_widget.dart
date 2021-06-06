import 'package:flutter/material.dart';
import 'package:should_have_bought_app/utils.dart';
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildVerticalGradientAreaChart(widget.value);
  }

  /// Returns the list of spline area series with vertical gradient.
  List<LineSeries<_ChartData, num>> _getDataLabelDefaultSeries(CurrentStockPrice value) {

    final List<_ChartData> dayHighData = <_ChartData>[];
    final List<_ChartData> weekHighData = <_ChartData>[];
    final List<_ChartData> yearHighData = <_ChartData>[];
    final List<_ChartData> defaltHighData = <_ChartData>[];
    final List<_ChartData> dayLowData = <_ChartData>[];
    final List<_ChartData> weekLowData = <_ChartData>[];
    final List<_ChartData> yearLowData = <_ChartData>[];
    final List<_ChartData> defaltLowData = <_ChartData>[];
    final List<Color> color = <Color>[];

    color.add(const Color(0xFFFF6258));

    dayHighData.add(_ChartData(1, value.dayHigh));
    weekHighData.add( _ChartData(5, value.weekHigh));
    yearHighData.add( _ChartData(9, value.yearHigh));
    defaltHighData.add(_ChartData(1, value.dayHigh));
    defaltHighData.add( _ChartData(5, value.weekHigh));
    defaltHighData.add( _ChartData(9, value.yearHigh));
    dayLowData.add(_ChartData(1, value.dayLow));
    weekLowData.add(_ChartData(5, value.weekLow));
    yearLowData.add(_ChartData(9, value.yearLow));
    defaltLowData.add(_ChartData(1, value.dayLow));
    defaltLowData.add(_ChartData(5, value.weekLow));
    defaltLowData.add(_ChartData(9, value.yearLow));

    LineSeries<_ChartData, num> daliyChart(String type) {
      return LineSeries<_ChartData, num>(
          animationDuration: 1500,
          legendIconType: LegendIconType.circle,
          dataSource: type == "high" ? dayHighData : dayLowData,
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
    LineSeries<_ChartData, num> weeklyChart(String type) {
      return LineSeries<_ChartData, num>(
          animationDuration: 1500,
          legendIconType: LegendIconType.circle,
          dataSource: type == "high" ? weekHighData : weekLowData,
          color: const Color(0xFFFF6258),
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
    LineSeries<_ChartData, num> yearlyChart(String type) {
      return LineSeries<_ChartData, num>(
          animationDuration: 1500,
          legendIconType: LegendIconType.circle,
          dataSource: type == "high" ? yearHighData : yearLowData,
          color: const Color(0xFFFF9900),
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
    LineSeries<_ChartData, num> defaultChart(String type) {
      return LineSeries<_ChartData, num>(
          animationDuration: 500,
          legendIconType: LegendIconType.circle,
          dataSource: type == "high" ? defaltHighData : defaltLowData,
          color: Colors.blueGrey,
          width: 2,
          name: '',
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          markerSettings: MarkerSettings(
            isVisible: false,
            width: 6,
            height: 6,
            color: Colors.blueGrey,
          ),
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            useSeriesColor: false,
            alignment: ChartAlignment.center,
            labelAlignment: ChartDataLabelAlignment.top,
            offset: Offset(0, 0),
          ));
    }
    if (widget.type == '최고가') {
      return <LineSeries<_ChartData, num>> [
        defaultChart('high'),
        daliyChart('high'),
        weeklyChart('high'),
        yearlyChart('high'),
      ];
    }

    return <LineSeries<_ChartData, num>>[
      defaultChart('low'),
      daliyChart('low'),
      weeklyChart('low'),
      yearlyChart('low'),
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
      onDataLabelRender: (DataLabelRenderArgs args) {
        dataLabel(args);
      },
      onLegendItemRender: (args) {
        if(args.seriesIndex == 0) {
          args.text = "";
          args.legendIconType = LegendIconType.image;
        }
      },
      //trackballBehavior: _trackballBehavior,
      series: _getDataLabelDefaultSeries(value),
    );
  }
}

void dataLabel(DataLabelRenderArgs args) {
  args.text = "${numberWithComma(args.text)}";
}

class _ChartData {
  _ChartData(this.x, this.y);

  final double x;
  final double y;
}

