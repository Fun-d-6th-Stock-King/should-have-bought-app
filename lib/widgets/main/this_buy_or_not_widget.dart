import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/buy_or_not/top_rank.dart';
import 'package:should_have_bought_app/models/buy_or_not/top_rank_evaluation.dart';
import 'package:should_have_bought_app/models/buy_or_not/top_rank_item.dart';
import 'package:should_have_bought_app/providers/buy_or_not/buy_or_not_provider.dart';
import 'package:should_have_bought_app/utils.dart';
import 'package:should_have_bought_app/widgets/button/buy_or_not_button_widget.dart';
import 'package:should_have_bought_app/widgets/text/prod_and_cons_widget.dart';

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
              height: 660,
              child: TabBarView(children: <Widget>[
                    BuyRanking(),
                    NotRanking()
                  ])
               )
        ]));
  }
}

const tabTitleStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 17,
  height: 25 / 17,
);
class BuyRanking extends StatefulWidget {
  @override
  _CreateBuyRankingState createState() => _CreateBuyRankingState();
}
class _CreateBuyRankingState extends State<BuyRanking> {
  @override
  void didChangeDependencies() async {
    await Provider.of<BuyOrNotProvider>(context,listen:false).getBuyRankList('BUY', 'SIMPLE');
  }
  //getBuyRankList
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Consumer<BuyOrNotProvider>(
          builder: (context, buyOrNotProvider, child) {
            TopRank topRank = buyOrNotProvider.topRank;
            List<TopRankItem> topRankList = topRank.topRankList;
            TopRankEvaluation evaluation = topRank.topRankEvaluation;
          return Column(
            children: [
              NumberOneRankWidget(topRankList.isEmpty == true ? TopRankItem() : topRankList[0], evaluation),
              SizedBox(height: 16),
              OtherRankWidget(1, topRankList.isEmpty == true ? TopRankItem() : topRankList[1]),
              SizedBox(height: 16),
              OtherRankWidget(2, topRankList.isEmpty == true ? TopRankItem() : topRankList[2]),
            ],
          );
        }
      ),
    );
  }
}

class NotRanking extends StatefulWidget {
  @override
  _CreateNotRankingState createState() => _CreateNotRankingState();
}

class _CreateNotRankingState extends State<NotRanking> {
  @override
  void didChangeDependencies() async {
    await Provider.of<BuyOrNotProvider>(context,listen:false).getBuyRankList('SELL', 'DETAIL');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Consumer<BuyOrNotProvider>(
          builder: (context, buyOrNotProvider, child) {
            TopRank topRank = buyOrNotProvider.topRank;
            List<TopRankItem> topRankList = topRank.topRankList;
            TopRankEvaluation evaluation = topRank.topRankEvaluation;
          return Column(
            children: [
              NumberOneRankWidget(topRankList.isEmpty == true ? TopRankItem() : topRankList[0], evaluation),
              SizedBox(height: 16),
              OtherRankWidget(1, topRankList.isEmpty == true ? TopRankItem() : topRankList[1]),
              SizedBox(height: 16),
              OtherRankWidget(2, topRankList.isEmpty == true ? TopRankItem() : topRankList[2]),
            ]
          );
        }
      ),
    );
  }
}

class OtherRankWidget extends StatelessWidget {
  final TopRankItem topRankItem;
  final int ranking;
  OtherRankWidget(this.ranking, this.topRankItem);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Color(0xFFF2F2F2),
        ),
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 15),
                    Text("${ranking+1}", style: rankingNumberStyle),
                    SizedBox(width: 20),
                    Text(topRankItem?.company ?? '',style: thisBuyOrNotWidgetTitleStyle),
                  ],
                ),
                SizedBox(height: 3),
                Row(
                  children: [
                    SizedBox(width: 45),
                    Row(
                      children: [
                        Text(emojiIncreaseOrDecrease(topRankItem?.changeInPercent ?? 0), style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            height: 16/14,
                            color: colorIncreaseOrDecrease(topRankItem?.changeInPercent ?? 0)
                        )),
                        Text(numberWithComma(topRankItem?.currentPrice.toString() ?? ''), style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            height: 16/14,
                            color: colorIncreaseOrDecrease(topRankItem?.changeInPercent ?? 0)
                        )),
                        Text("원 (${checkIncreaseOrDecrease(topRankItem?.changeInPercent)}${topRankItem?.changeInPercent}%)", style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            height: 16/14,
                            color: colorIncreaseOrDecrease(topRankItem?.changeInPercent ?? 0)
                        )),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage('assets/icons/ico_like_small.png'),),
                      SizedBox(width: 1),
                      Text('살?', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15,color: likeColor),),
                      SizedBox(width: 5),
                      Text("${numberWithComma(topRankItem?.buyCnt.toString() ?? '')}", style: valueNumberStyle),
                      SizedBox(width: 23),
                      Container(
                          height: 20,
                          child: VerticalDivider(color: Color(0xFFDADADA))),
                      SizedBox(width: 23),
                      Image(image: AssetImage('assets/icons/ico_unlike_small.png'),),
                      SizedBox(width: 1),
                      Text('말?', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15,color: unlikeColor)),
                      SizedBox(width: 5),
                      Text("${numberWithComma(topRankItem?.sellCnt.toString() ?? '')}", style: valueNumberStyle),
                    ],
                  ),
                )
              ],
            )));
  }
}

class NumberOneRankWidget extends StatelessWidget {
  final TopRankItem topRankItem;
  final TopRankEvaluation evaluation;
  NumberOneRankWidget(this.topRankItem, this.evaluation);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Color(0xFFF2F2F2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 15),
                  Text('1', style: rankingNumberStyle),
                  SizedBox(width: 20),
                  Text(topRankItem?.company ?? '', style: thisBuyOrNotWidgetTitleStyle),
                ],
              ),
              SizedBox(height: 3),
              Row(
                children: [
                  SizedBox(width: 45),
                  Text(emojiIncreaseOrDecrease(topRankItem?.changeInPercent ?? 0), style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 16/14,
                      color: colorIncreaseOrDecrease(topRankItem?.changeInPercent ?? 0)
                  )),
                  Text(numberWithComma(topRankItem?.currentPrice.toString() ?? ''), style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 16/14,
                      color: colorIncreaseOrDecrease(topRankItem?.changeInPercent ?? 0)
                  )),
                  Text("원 (${checkIncreaseOrDecrease(topRankItem?.changeInPercent)}${topRankItem?.changeInPercent}%)", style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 16/14,
                      color: colorIncreaseOrDecrease(topRankItem?.changeInPercent ?? 0)
                  )),
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
                    BuyOrNotButtonWidget(
                      type: "BUY",
                      value: topRankItem?.buyCnt ?? 0, //buyOrNotStock?.buyCount ?? 0,
                      onTap: () {
                        //actionEvaluation(context, buyOrNotStock, 'BUY');
                      },
                      isChecked: true,
                    ),
                    SizedBox(width: 23),
                    Container(
                        height: 50,
                        child: VerticalDivider(color: Color(0xFFDADADA))),
                    SizedBox(width: 23),
                    BuyOrNotButtonWidget(
                      type: "SELL",
                      value: topRankItem?.sellCnt ?? 0, //buyOrNotStock?.buyCount ?? 0,
                      onTap: () {
                        //actionEvaluation(context, buyOrNotStock, 'BUY');
                      },
                      isChecked: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: 105,
                padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(evaluation?.displayName ?? '', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, height: 20/14)),
                        SizedBox(width: 10),
                        Text(evaluation?.createdDateText ?? '', style:dateNumberStyle)
                      ],
                    ),
                    SizedBox(height: 10),
                    ProsAndConsWidget(
                      pros: evaluation?.pros ?? '',
                      //evaluationItem?.pros ?? '',
                      cons: evaluation?.cons ?? '',
                      //evaluationItem?.cons ?? '',
                      isLoading: false, //isLoadihg,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

const thisBuyOrNotWidgetTitleStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 17,
);
const valueNumberStyle = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 16,
);
const rankingNumberStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
  color: mainColor
);

const dateNumberStyle = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 12,
  color: Color(0xFF8C8C8C)
);

const possibleStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 16/14,
    color: possibleColor
);