import 'package:flutter/material.dart';

class IncreaseRateTabWidget extends StatefulWidget {
  @override
  _IncreaseRateTabWidgetState createState() => _IncreaseRateTabWidgetState();
}

class _IncreaseRateTabWidgetState extends State<IncreaseRateTabWidget> {
  List _sectorList = [
    '삼성전자',
    'SK하이닉스',
    '원익IPS',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
                    text: '동일업종()',
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
                  '+ 286%',
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
            height: 50,
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
                                fontSize: 24, fontWeight: FontWeight.w400),
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
                                fontSize: 24, fontWeight: FontWeight.w400),
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
                        itemCount: _sectorList.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 25);
                        },
                        itemBuilder: (context, index) {
                          return FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Container(
                              // margin: EdgeInsets.all(10),
                              height: 30,
                              decoration: BoxDecoration(
                                color: Color(0x17939393),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25.0),
                                ),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  _sectorList[index],
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
                    SizedBox(height: 5),
                    Center(
                      child: Text('외 40개 코스피 성장 기업 평균'),
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
