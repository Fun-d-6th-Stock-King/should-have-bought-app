import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/models/calculator/calculator_stock.dart';
import 'package:should_have_bought_app/models/calculator/result/sectorData.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';

class IncreaseRateTabWidget extends StatefulWidget {
  @override
  _IncreaseRateTabWidgetState createState() => _IncreaseRateTabWidgetState();
}

class _IncreaseRateTabWidgetState extends State<IncreaseRateTabWidget> {
  Color kospiBoxColor;
  Color industryBoxColor;

  void setBoxColor() {
    final sectorData =
        Provider.of<CalculatorProvider>(context, listen: false).sectorData;
    if (sectorData.kospiYieldPercent > 0) {
      setState(() {
        kospiBoxColor = Color(0xffFFEFF0);
      });
    } else {
      setState(() {
        kospiBoxColor = Color(0xff4990FF);
      });
    }

    if (sectorData.industrYieldPercent > 0) {
      setState(() {
        industryBoxColor = Color(0xffFFEFF0);
      });
    } else {
      setState(() {
        industryBoxColor = Color(0xff4990FF);
      });
    }
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    await Provider.of<CalculatorProvider>(context, listen: false)
        .getSectorData()
        .then((value) {
      setBoxColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
        builder: (context, calculatorProvider, child) {
      SectorData sectorData = calculatorProvider.sectorData;
      CalculatorStock calculationResult = calculatorProvider.calculationResult;
      return sectorData == null
          ? Container(child: CircularProgressIndicator())
          : DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '기간 내 상승률',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: TabBar(
                      isScrollable: true,
                      indicatorWeight: 3.0,
                      labelStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      labelColor: Colors.black,
                      unselectedLabelColor: Color(0xff979797),
                      tabs: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 43,
                          ),
                          child: Tab(
                            text: '코스피',
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(minWidth: 210),
                          child: Tab(
                            text: '동일업종(${sectorData.sectorKor})',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 180,
                    child: TabBarView(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 93,
                              decoration: BoxDecoration(
                                color: kospiBoxColor,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child:
                                  KospiPerYield(sectorData, calculationResult),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      '2011년 03월 11일',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff828282),
                                      ),
                                    ),
                                    Text(
                                      sectorData.kospiOldStock
                                          .toStringAsFixed(2),
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      '2021년 03월 11일',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff828282),
                                      ),
                                    ),
                                    Text(
                                      sectorData.kospiCurrentStock
                                          .toStringAsFixed(2),
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              child: Container(
                                width: double.infinity,
                                height: 93,
                                decoration: BoxDecoration(
                                  color: industryBoxColor,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: IndustryYield(sectorData),
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              height: 25,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: sectorData.companies.length,
                                separatorBuilder: (context, index) {
                                  return SizedBox(width: 10);
                                },
                                itemBuilder: (context, index) {
                                  return FittedBox(
                                    fit: BoxFit.cover,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(25.0),
                                          ),
                                          border: Border.all(
                                            color: Color(0xff26737373),
                                          )),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 3.0),
                                        child: Text(
                                          sectorData.companies[index]
                                              ['company'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: Text(
                                '외 ${sectorData.companyCnt}개 코스피 성장 기업 평균',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff828282),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
    });
  }
}

class IndustryYield extends StatelessWidget {
  final SectorData sectorData;

  IndustryYield(this.sectorData);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: sectorData.industrYieldPercent > 0
            ? Text(
                '+ ${sectorData.industrYieldPercent}%',
                style: TextStyle(
                    fontSize: 36,
                    color: Colors.red,
                    fontWeight: FontWeight.w500),
              )
            : Text(
                '${sectorData.industrYieldPercent}%',
                style: TextStyle(
                    fontSize: 36,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500),
              ));
  }
}

class KospiPerYield extends StatelessWidget {
  final SectorData sectorData;
  final CalculatorStock calculationResult;

  KospiPerYield(this.sectorData, this.calculationResult);

  @override
  Widget build(BuildContext context) {
    final kospiPercent = sectorData.kospiYieldPercent;
    final yieldPercent = calculationResult.yieldPercent;

    return (kospiPercent > yieldPercent)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${sectorData.kospiYieldPercent ?? 0}%',
                style: TextStyle(
                    fontSize: 36,
                    color: Colors.red,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                '👎코스피 오르는 동안 넌 뭐했니?',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          )
        : (kospiPercent < yieldPercent)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '+ ${sectorData.kospiYieldPercent ?? 0}%',
                    style: TextStyle(
                        fontSize: 36,
                        color: Colors.red,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '👍코스피보다 나은 효자 종목',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${sectorData.kospiYieldPercent ?? 0}%',
                    style: TextStyle(
                        fontSize: 36,
                        color: Colors.red,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '🤔씁... 나쁘진 않은데...',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              );
  }
}
