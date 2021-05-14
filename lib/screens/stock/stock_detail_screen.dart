import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/buy_or_not/buy_or_not_stock.dart';
import 'package:should_have_bought_app/models/drip_room/evaluation_item.dart';
import 'package:should_have_bought_app/providers/buy_or_not/buy_or_not_provider.dart';
import 'file:///D:/git/workspace/fun_d_6/should-have-bought-app/lib/screens/drip_room/drip_room_tab_screen.dart';

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

class BuyorNotTabScreen extends StatelessWidget {
  final EvaluationItem evaluationItem;

  BuyorNotTabScreen(this.evaluationItem);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          BuyorNotSelectWidget(evaluationItem.code),
          SizedBox(height: 20),
          Container(
            child: Text('hello'),
          )
        ],
      ),
    );
  }
}

class BuyorNotSelectWidget extends StatefulWidget {
  final String stockCode;

  BuyorNotSelectWidget(this.stockCode);
  _CreateBuyorNotSelectWidgetState createState() =>
      _CreateBuyorNotSelectWidgetState();
}

class _CreateBuyorNotSelectWidgetState extends State<BuyorNotSelectWidget> {

  @override
  void initState() {
    Provider.of<BuyOrNotProvider>(context, listen:false).getBuyOrNotStock(widget.stockCode);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BuyOrNotProvider>(
      builder: (context, buyOrNotProvider, child) {
        BuyOrNotStock buyOrNotStock = buyOrNotProvider.buyOrNotStock;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
          height: 82,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: ClipOval(
                    child: Container(
                      color: buyOrNotStock.userBuySell == "BUY" ? likeColor : disableColor,
                      padding: EdgeInsets.only(bottom: 5),
                      child:
                          Image(image: AssetImage('assets/icons/ico_like_big.png')),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '살래?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    height: 20 / 14,
                    color: likeColor,
                  ),
                ),
                Text("${buyOrNotStock?.buyCount ?? 0}", style: buyOrNotCountTextStyle),
              ],
            ),
            SizedBox(width: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: ClipOval(
                    child: Container(
                      color: buyOrNotStock.userBuySell == "SELL" ? nagativeColor : disableColor,
                      child:
                          Image(image: AssetImage('assets/icons/ico_unlike_big.png')),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '말래?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    height: 20 / 14,
                    color: unlikeColor,
                  ),
                ),
                Text("${buyOrNotStock?.sellCount ?? 0}", style: buyOrNotCountTextStyle),
              ],
            ),
          ]),
        );
      }
    );
  }
}

const tabStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 16,
  height: 23 / 16,
);

const buyOrNotCountTextStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 15,
  height: 18 / 15,
  color: Color(0xFF4F4F4F),
);
