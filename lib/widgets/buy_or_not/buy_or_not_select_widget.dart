import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/buy_or_not/buy_or_not_stock.dart';
import 'package:should_have_bought_app/providers/buy_or_not/buy_or_not_provider.dart';
import 'package:should_have_bought_app/screens/util/loading_screen.dart';
import 'package:should_have_bought_app/screens/util/skeleton_widget.dart';
import 'package:should_have_bought_app/utils.dart';
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
              InkWell(
                onTap: () {
                  print('살래');
                  isLoading ? null :actionEvaluation(context, buyOrNotStock, 'BUY');
                },
                child:Wrap(
                  children: [
                    isLoading ? LoadingScreen() : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: ClipOval(
                            child: Container(
                              color: buyOrNotStock.userBuySell == "BUY"
                                  ? likeColor
                                  : disableColor,
                              padding: EdgeInsets.only(bottom: 5),
                              child: Image(image: AssetImage('assets/icons/ico_like_big.png')),
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
                        isLoading ? skeletonText(30, 15) : Text("${buyOrNotStock?.buyCount ?? 0}",
                            style: buyOrNotCountTextStyle),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 50),
              InkWell(
                onTap: () {
                  print('말래');
                  isLoading ? null : actionEvaluation(context, buyOrNotStock, 'SELL');
                },
                child: Wrap(
                  children: [
                    isLoading ? LoadingScreen() : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: ClipOval(
                            child: Container(
                              color: buyOrNotStock.userBuySell == "SELL"
                                  ? nagativeColor
                                  : disableColor,
                              child: Image(
                                  image: AssetImage(
                                      'assets/icons/ico_unlike_big.png')),
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
                        isLoading ? skeletonText(30, 15) : Text("${buyOrNotStock?.sellCount ?? 0}",
                            style: buyOrNotCountTextStyle),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          );
        });
  }
}