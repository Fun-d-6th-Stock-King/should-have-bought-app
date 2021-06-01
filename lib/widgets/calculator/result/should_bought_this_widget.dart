import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ShouldBoughtThisWidget extends StatefulWidget {
  @override
  _ShouldBoughtThisWidgetState createState() => _ShouldBoughtThisWidgetState();
}

class _ShouldBoughtThisWidgetState extends State<ShouldBoughtThisWidget> {
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
                '검색 기간동안 가장 많이 오른 종목',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF828282),
                ),
              ),
              Text(
                '이것도 살걸',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 130,
          child: ListView(
            children: <Widget>[
              StockTile(
                index: 1,
                company: '한국타이어테크놀로지',
              ),
              StockTile(
                index: 2,
                company: '삼성전자',
              ),
              StockTile(
                index: 3,
                company: '카카오',
              ),
            ],
          ),
        )
      ],
    );
  }
}

class StockTile extends StatelessWidget {
  final int index;
  final String company;
  const StockTile({this.index, this.company});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: Text(index.toString()),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 120,
              minWidth: 120,
            ),
            child: AutoSizeText(
              company,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color(0xFF141414),
              ),
              maxLines: 1,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 80,
            ),
            child: AutoSizeText(
              '1,900,211원',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color(0xFF858585),
              ),
              maxLines: 1,
            ),
          ),
          FittedBox(
            fit: BoxFit.cover,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
              child: AutoSizeText(
                '+300.39%',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                minFontSize: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Color(0xFFFF6561).withOpacity(0.14),
              ),
            ),
          )
        ],
      ),
    );
  }
}
