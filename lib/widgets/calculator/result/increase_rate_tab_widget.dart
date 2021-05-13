import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';

class IncreaseRateTabWidget extends StatefulWidget {
  @override
  _IncreaseRateTabWidgetState createState() => _IncreaseRateTabWidgetState();
}

class _IncreaseRateTabWidgetState extends State<IncreaseRateTabWidget> {
  bool _isLoading = false;
  bool _isApiCall;

  @override
  void initState() {
    _isApiCall = false;
    print("call");
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (!_isApiCall) {
      final _companyCode =
          Provider.of<CalculatorProvider>(context).latestDto['code'];
      final _investDate =
          Provider.of<CalculatorProvider>(context).latestDto['investDate'];
      final _investPrice = int.parse(
          Provider.of<CalculatorProvider>(context).latestDto['investPrice']);
      setState(() {
        _isLoading = true;
      });
      await Provider.of<CalculatorProvider>(context, listen: false)
          .getSectorData(_companyCode, _investDate, _investPrice)
          .then((value) => {
                setState(() {
                  _isLoading = false;
                })
              });
      _isApiCall = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
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
                  width: double.infinity,
                  height: 93,
                  decoration: BoxDecoration(
                    color: Color(0xffFFEFF0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${Provider.of<CalculatorProvider>(context).sectorData.kospiYieldPercent}%',
                        style: TextStyle(
                            fontSize: 32,
                            color: Color(0xffFF6B76),
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
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 60,
                  child: TabBarView(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  '1995.54',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
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
                                  '2,432.07',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
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
                                return SizedBox(width: 25);
                              },
                              itemBuilder: (context, index) {
                                return FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0x17939393),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(25.0),
                                      ),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        Provider.of<CalculatorProvider>(context)
                                            .sectorData
                                            .companies[index]['company'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
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
                                '외 ${Provider.of<CalculatorProvider>(context).sectorData.companyCnt}개 코스피 성장 기업 평균'),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
