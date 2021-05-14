import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';

class IncreaseRateTabWidget extends StatefulWidget {
  @override
  _IncreaseRateTabWidgetState createState() => _IncreaseRateTabWidgetState();
}

class _IncreaseRateTabWidgetState extends State<IncreaseRateTabWidget> {
  Color kospiBoxColor;
  Color industryBoxColor;

  void setBoxColor() {
    if (Provider.of<CalculatorProvider>(context).sectorData.kospiYieldPercent >
        0) {
      kospiBoxColor = Color(0xffFFEFF0);
    } else {
      kospiBoxColor = Color(0xff4990FF);
    }

    if (Provider.of<CalculatorProvider>(context)
            .sectorData
            .industrYieldPercent >
        0) {
      industryBoxColor = Color(0xffFFEFF0);
    } else {
      industryBoxColor = Color(0xff4990FF);
    }
  }

  @override
  Widget build(BuildContext context) {
    setBoxColor();
    return Provider.of<CalculatorProvider>(context).sectorData == null
        ? CircularProgressIndicator()
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
                          text:
                              '동일업종(${Provider.of<CalculatorProvider>(context).sectorData.sectorKor})',
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
                            child: KospiPerYield(),
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
                                    Provider.of<CalculatorProvider>(context)
                                        .sectorData
                                        .kospiOldStock
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
                                    Provider.of<CalculatorProvider>(context)
                                        .sectorData
                                        .kospiCurrentStock
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
                              child: IndustryYield(),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 25,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  Provider.of<CalculatorProvider>(context)
                                      .sectorData
                                      .companies
                                      .length,
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
                                        Provider.of<CalculatorProvider>(context)
                                            .sectorData
                                            .companies[index]['company'],
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
                              '외 ${Provider.of<CalculatorProvider>(context).sectorData.companyCnt}개 코스피 성장 기업 평균',
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
  }
}

class IndustryYield extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Provider.of<CalculatorProvider>(context)
                    .sectorData
                    .industrYieldPercent >
                0
            ? Text(
                '+ ${Provider.of<CalculatorProvider>(context).sectorData.industrYieldPercent}%',
                style: TextStyle(
                    fontSize: 36,
                    color: Colors.red,
                    fontWeight: FontWeight.w500),
              )
            : Text(
                '${Provider.of<CalculatorProvider>(context).sectorData.industrYieldPercent}%',
                style: TextStyle(
                    fontSize: 36,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500),
              ));
  }
}

class KospiPerYield extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final kospiPercent =
        Provider.of<CalculatorProvider>(context).sectorData.kospiYieldPercent;
    final yieldPercent =
        Provider.of<CalculatorProvider>(context).calculationResult.yieldPercent;

    return (kospiPercent > yieldPercent)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${Provider.of<CalculatorProvider>(context).sectorData.kospiYieldPercent}%',
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
                    '+ ${Provider.of<CalculatorProvider>(context).sectorData.kospiYieldPercent}%',
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
                    '${Provider.of<CalculatorProvider>(context).sectorData.kospiYieldPercent}%',
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
