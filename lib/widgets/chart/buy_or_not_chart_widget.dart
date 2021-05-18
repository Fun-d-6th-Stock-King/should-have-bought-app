import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/buy_or_not/buy_or_not_chart.dart';
import 'package:should_have_bought_app/models/buy_or_not/stock_hist.dart';
import 'package:should_have_bought_app/providers/buy_or_not/buy_or_not_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BuyOrNotChartWidget extends StatefulWidget {
  final String stockCode;

  BuyOrNotChartWidget(this.stockCode);

  @override
  _BuyOrNotChartWidgetState createState() => _BuyOrNotChartWidgetState();
}

/// State class of horizontal gradient.
class _BuyOrNotChartWidgetState extends State<BuyOrNotChartWidget> {
  List<BuyOrNotChart> chartData = [];

  StockHist stockHist = StockHist();

  @override
  void initState() {
    // _tooltipBehavior = TooltipBehavior(enable: true, canShowMarker: false);
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    chartData = Provider.of<BuyOrNotProvider>(context, listen: false)
        .stockHist
        .quoteList;
    stockHist = Provider.of<BuyOrNotProvider>(context, listen: false).stockHist;
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
      onMarkerRender: (args) {
        if(chartData[args.pointIndex].high == stockHist.maxQuote.high) {
          args.color  =Color(0x66FF8888);
          args.shape = DataMarkerType.circle;
        }
        else {
          if(chartData[args.pointIndex].low == stockHist.minQuote.low) {
            args.color = Color(0x665D99F2);
            args.shape = DataMarkerType.circle;
          }
        }
      },
      primaryYAxis: NumericAxis(
          isVisible: false,
          interval: null,
          labelFormat: '{value}',
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(size: 0)),
      series: _getGradientAreaSeries(),
    );
  }

  /// Returns the list of spline area series with horizontal gradient.
  List<ChartSeries<BuyOrNotChart, String>> _getGradientAreaSeries() {
    final List<double> stops = <double>[];
    stops.add(0.2);
    stops.add(0.7);

    return <ChartSeries<BuyOrNotChart, String>>[
      SplineAreaSeries<BuyOrNotChart, String>(
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
          name: 'buy_or_not_chart_widget',
          markerSettings: MarkerSettings(
              isVisible: true,
              height: 11,
              width: 11,
              shape: DataMarkerType.circle,
              borderColor: Colors.red,
              color: Colors.transparent,
              borderWidth: 0
          ),
          xValueMapper: (BuyOrNotChart buyOrNotChart, _) => buyOrNotChart.date,
          yValueMapper: (BuyOrNotChart buyOrNotChart, _) => buyOrNotChart.close),
    ];
  }
}