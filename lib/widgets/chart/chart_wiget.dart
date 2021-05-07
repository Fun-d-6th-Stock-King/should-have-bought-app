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
  List<LineSeries<_ChartData, num>> _getDataLabelDefaultSeries() {
    final List<_ChartData> chartData = <_ChartData>[
      _ChartData(2005, 10, 28),
      _ChartData(2006, 24, 44),
      _ChartData(2007, 36, 48),
      _ChartData(2008, 38, 50),
      _ChartData(2009, 54, 66),
      _ChartData(2010, 57, 78),
      _ChartData(2011, 70, 84),
      _ChartData(2012, 40, 28),
      _ChartData(2013, 44, 44),
      _ChartData(2014, 36, 48),
      _ChartData(2015, 38, 50),
      _ChartData(2016, 54, 66),
      _ChartData(2017, 57, 78),
      _ChartData(2018, 70, 84),
    ];
    final List<_ChartData> chartData2 = <_ChartData>[
      _ChartData(2005, 10, 28),
      _ChartData(2011, 70, 84)
    ];
    final List<Color> color = <Color>[];
    color.add(const Color(0xFFFF6258));

    final List<double> stops = <double>[];
    stops.add(0.1);
    stops.add(0.4);

    return <LineSeries<_ChartData, num>>[

      LineSeries<_ChartData, num>(
          animationDuration: 0,
          legendIconType: LegendIconType.rectangle,
          dataSource: chartData,
          color: const Color(0xFFFF6258),
          width: 4,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          markerSettings: MarkerSettings(isVisible: false),
          name: 'Singapore',
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            useSeriesColor: false,
            alignment: ChartAlignment.center,
            labelAlignment: ChartDataLabelAlignment.top,
            offset: Offset(0, 0),
          )),
      // LineSeries<_ChartData, num>(
      //     animationDuration: 0,
      //     dataSource: chartData2,
      //     color: Colors.transparent,
      //     width: 2,
      //     name: 'England',
      //     xValueMapper: (_ChartData sales, _) => sales.x,
      //     yValueMapper: (_ChartData sales, _) => sales.y,
      //     markerSettings: MarkerSettings(isVisible: false),
      //     dataLabelSettings: DataLabelSettings(
      //       isVisible: true,
      //       useSeriesColor: false,
      //       alignment: ChartAlignment.center,
      //       labelAlignment: ChartDataLabelAlignment.top,
      //       offset: Offset(0, 0),
      //     )),
      // SplineAreaSeries<_ChartData, String>(
      //   /// To set the gradient colors for series.
      //     gradient: const LinearGradient(colors: <Color>[
      //       Color.fromRGBO(269, 210, 255, 1),
      //       Color.fromRGBO(143, 236, 154, 1)
      //     ], stops: <double>[
      //       0.2,
      //       0.6
      //     ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
      //     borderWidth: 2,
      //     //borderColor: const Color.fromRGBO(0, 156, 144, 1),
      //     borderDrawMode: BorderDrawMode.top,
      //     dataSource: chartData,
      //     name: 'Country 1',
      //     xValueMapper: (_ChartData sales, _) => sales.x,
      //     yValueMapper: (_ChartData sales, _) => sales.y),
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
        maximum: 100,
        interval: 4,
        labelFormat: '{value}',
        axisLine: AxisLine(width: 0),
      ),
      onDataLabelRender: (DataLabelRenderArgs args) {
         dataLabel(args);
      },
      //trackballBehavior: _trackballBehavior,
      series: _getDataLabelDefaultSeries(),
    );
  }
}

void dataLabel(DataLabelRenderArgs args) {
  if(args.pointIndex == 0) {
     args.textStyle = TextStyle(color:Color(0xFF5D99F2), fontWeight: FontWeight.bold);
     args.offset = Offset(0,-30);
     args.text = "최저 ${args.text}";
   }
   else if (args.pointIndex == args.dataPoints.length-1) {
     args.textStyle = TextStyle(color:Color(0xFFFF6258), fontWeight: FontWeight.bold);
     args.offset = Offset(0,30);
     args.text = "최고 ${args.text}";
   } else {
    args.text = "";
  }
}
class _ChartData {
  _ChartData(this.x, this.y, this.y2);
  final double x;
  final double y;
  final double y2;
}