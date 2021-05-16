import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/drip_room/evaluation_item.dart';
import 'package:should_have_bought_app/screens/drip_room/drip_room_tab_screen.dart';
import 'package:should_have_bought_app/screens/buy_or_not/buy_or_not_tab_screen.dart';

class StockDetailScreen extends StatefulWidget {
  final EvaluationItem evaluationItem;
  final int initialIndex;

  StockDetailScreen(this.evaluationItem, this.initialIndex);

  @override
  _StockDetailScreenState createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends State<StockDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.initialIndex,
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: defaultBackgroundColor,
          leading: InkWell(
              child: Icon(Icons.keyboard_arrow_left_outlined),
              onTap: () => Navigator.pop(context)),
          elevation: 0,
          centerTitle: true,
          title: Text(widget.evaluationItem.company, style: tabStyle),
          bottom: TabBar(
            tabs: [
              Tab(child: Text('살래말래', style: tabStyle)),
              Tab(child: Text('드립방', style: tabStyle)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BuyorNotTabScreen(widget.evaluationItem),
            DripRoomTabScreen(),
          ],
        ),
      ),
    );
  }
}



const tabStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 16,
  height: 23 / 16,
);

