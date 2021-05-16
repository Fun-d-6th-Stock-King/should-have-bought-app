import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/buy_or_not/buy_or_not_stock.dart';
import 'package:should_have_bought_app/models/drip_room/evaluation_item.dart';
import 'package:should_have_bought_app/providers/buy_or_not/buy_or_not_provider.dart';
import 'package:should_have_bought_app/widgets/chart/buy_or_not_chart_widget.dart';
import 'package:should_have_bought_app/widgets/login/login_handler.dart';

class BuyorNotTabScreen extends StatelessWidget {
  final EvaluationItem evaluationItem;

  BuyorNotTabScreen(this.evaluationItem);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            BuyorNotSelectWidget(evaluationItem.code),
            SizedBox(height: 20),
            HowToBoughtThenWidget(evaluationItem.code),
          ],
        ),
      ),
    );
  }
}

class HowToBoughtThenWidget extends StatelessWidget {
  final String stockCode;
  HowToBoughtThenWidget(this.stockCode);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: BuyOrNotChartWidget(stockCode)),
              ),
              Padding(
                padding: const EdgeInsets.all(29),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '2021.01.10.13:45',
                      style: dateStyle,
                    ),
                    Text('삼성전자', style: stockTitleStyle),
                    Text('395,820원', style: stockTitleStyle),
                    Text('+2,500 (295%)',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            height: 16 / 14,
                            color: Color(0xFF4990FF))),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text('최근 10년간', style: stockBodyStyle),
                      Text(
                        ' 최고가',
                        style: TextStyle(
                          fontSize: 14,
                          height: 20 / 14,
                          color: likeColor,
                        ),
                      )
                    ],
                  ),
                  Text('96,800원', style: stockBodyNumberStyle),
                  Text('2021-01-11 종가 기준', style: stockDateStyle),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text('최근 10년간', style: stockBodyStyle),
                      Text(
                        ' 최저가',
                        style: TextStyle(
                          fontSize: 14,
                          height: 20 / 14,
                          color: unlikeColor,
                        ),
                      )
                    ],
                  ),
                  Text('21,160원', style: stockBodyNumberStyle),
                  Text('2011-12-29 종가 기준', style: stockDateStyle),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: mainColor,
                    onPrimary: mainColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          16.0), //side: BorderSide(color: Colors.red)
                    )),
                onPressed: () {},
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '그때 샀으면 지금 얼마게?',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    ],
                  ),
                )),
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    Provider.of<BuyOrNotProvider>(context, listen: false)
        .getBuyOrNotStock(widget.stockCode);
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
          InkWell(
            onTap: () {
              print('살래');
              _auth.currentUser == null
                  ? LoginHandler(context)
                  : setEvaluation();
            },
            child: Wrap(
              children: [
                Column(
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
                          child: Image(
                              image: AssetImage('assets/icons/ico_like_big.png')),
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
                    Text("${buyOrNotStock?.buyCount ?? 0}",
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
              _auth.currentUser == null
                  ? LoginHandler(context)
                  : setEvaluation();
            },
            child: Wrap(
              children: [
                Column(
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
                              image: AssetImage('assets/icons/ico_unlike_big.png')),
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
                    Text("${buyOrNotStock?.sellCount ?? 0}",
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

void setEvaluation() {
}

const buyOrNotCountTextStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 15,
  height: 18 / 15,
  color: Color(0xFF4F4F4F),
);

const dateStyle = TextStyle(
  fontSize: 11,
  height: 13 / 11,
  color: Color(0XFFBDBDBD),
);

const stockDateStyle = TextStyle(
  fontSize: 11,
  height: 13 / 11,
  color: Color(0xFF828282),
);

const stockTitleStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 22, height: 32 / 22);

const stockBodyStyle = TextStyle(
  fontSize: 14,
  height: 20 / 14,
);

const stockBodyNumberStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 21,
  height: 25 / 21,
);
