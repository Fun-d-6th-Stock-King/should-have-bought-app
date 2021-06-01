import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/buy_or_not/buy_or_not_stock.dart';
import 'package:should_have_bought_app/providers/buy_or_not/buy_or_not_provider.dart';
import 'package:should_have_bought_app/screens/util/loading_screen.dart';
import 'package:should_have_bought_app/screens/util/skeleton_widget.dart';
import 'package:should_have_bought_app/utils.dart';
import 'package:should_have_bought_app/widgets/button/buy_or_not_button_widget.dart';
import 'package:should_have_bought_app/widgets/login/login_handler.dart';

class BuyorNotSelectWidget extends StatefulWidget {
  final String stockCode;

  BuyorNotSelectWidget(this.stockCode);

  _CreateBuyorNotSelectWidgetState createState() =>
      _CreateBuyorNotSelectWidgetState();
}

class _CreateBuyorNotSelectWidgetState extends State<BuyorNotSelectWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  void didChangeDependencies() {
    Provider.of<BuyOrNotProvider>(context, listen: false).setBuyOrNotLoading(true);
    Provider.of<BuyOrNotProvider>(context, listen: false)
        .getBuyOrNotStock(widget.stockCode).then((value) =>
        Provider.of<BuyOrNotProvider>(context, listen: false).setBuyOrNotLoading(false));
  }

  void setEvaluation(String stockCode, String buySell) async {
    await Provider.of<BuyOrNotProvider>(context, listen: false)
        .setBuyOrNotStock(stockCode, buySell);
  }

  String parseWasEvaluation(BuyOrNotStock buyOrNotStock, String buySell) {
    return buyOrNotStock.userBuySell == buySell ? 'NULL' : buySell;
  }

  void actionEvaluation(
      BuildContext context, BuyOrNotStock buyOrNotStock, String buySell) async{
    if (isNotLogin(_auth.currentUser)) {
      LoginHandler(context, buyOrNotStockCode:buyOrNotStock.code);
      return;
    }
    String _buySell = parseWasEvaluation(buyOrNotStock, buySell);
    setEvaluation(buyOrNotStock.code, _buySell);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BuyOrNotProvider>(
        builder: (context, buyOrNotProvider, child) {
          BuyOrNotStock buyOrNotStock = buyOrNotProvider.buyOrNotStock;
          bool isLoading = buyOrNotProvider.isLoadingBuyOrNot;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
            ),
            height: 82,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              BuyOrNotButtonWidget(
                 type: "BUY",
                value: buyOrNotStock?.buyCount ?? 0,
                onTap: () {
                  actionEvaluation(context, buyOrNotStock, 'BUY');
                },
                isChecked: buyOrNotStock.userBuySell == "BUY" ? true : false,
              ),
              SizedBox(width: 50),
              BuyOrNotButtonWidget(
                type: "SELL",
                value: buyOrNotStock?.sellCount ?? 0,
                onTap: () {
                  actionEvaluation(context, buyOrNotStock, 'SELL');
                },
                isChecked: buyOrNotStock.userBuySell == "SELL" ? true : false,
              ),
            ]),
          );
        });
  }
}

