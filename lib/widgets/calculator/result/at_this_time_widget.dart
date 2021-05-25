import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';

class AtThisTimeWidget extends StatefulWidget {
  @override
  _AtThisTimeWidgetState createState() => _AtThisTimeWidgetState();
}

class _AtThisTimeWidgetState extends State<AtThisTimeWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '이때 살걸',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '2021-01-11 종가 기준',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: mainColor,
          ),
          unselectedLabelColor: Colors.black,
          unselectedLabelStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          labelStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
          tabs: <Widget>[
            Tab(
              child: Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('어제 살껄'),
                ),
              ),
            ),
            Tab(
              text: '저번주에 살걸',
            ),
            Tab(
              text: '작년에 살걸',
            ),
            Tab(
              text: '10년전에 살걸',
            ),
          ],
        ),
        Container(
          height: 300,
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              Center(
                child: Text('111'),
              ),
              Center(
                child: Text('222'),
              ),
              Center(
                child: Text('333'),
              ),
              Center(
                child: Text('444'),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class TabText extends StatelessWidget {
  final String text;
  const TabText({this.text});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: FittedBox(
        fit: BoxFit.cover,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 3,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
