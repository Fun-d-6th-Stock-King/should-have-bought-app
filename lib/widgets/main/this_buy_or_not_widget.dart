import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';

class ThisBuyOrNotWidget extends StatefulWidget {
  @override
  _CreateThisBuyOrNotWidgetState createState() =>
      _CreateThisBuyOrNotWidgetState();
}

class _CreateThisBuyOrNotWidgetState extends State<ThisBuyOrNotWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2, // length of tabs
        initialIndex: 0,
        child: Column(children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.55,
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: mainColor,
              indicatorWeight: 4,
              labelStyle: tabTitleStyle,
              unselectedLabelColor: Color(0xFF979797),
              tabs: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Tab(text: '살까 랭킹'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Tab(text: '말까 랭킹'),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Container(
              height: 600,
              child: TabBarView(children: <Widget>[
                BuyRanking(),
                Container(
                  child: Center(
                    child: Text('Display Tab 2',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                ),
              ]))
        ]));
  }
}

const tabTitleStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 17,
  height: 25 / 17,
);

class BuyRanking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0),
                color: Color(0xFFF2F2F2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('1'),
                        SizedBox(width: 20),
                        Text('한국타이어앤테크놀로지'),
                        SizedBox(width: 3),
                        Text('^'),
                        Text('1,395,820원'),
                        Text('(+295%)'),
                      ],
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('살?'),
                          Container(height: 34, child: VerticalDivider(color: Colors.red)),
                          Text('말?')
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 105,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('살?'),
                          Container(height: 34, child: VerticalDivider(color: Colors.red)),
                          Text('말?')
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
