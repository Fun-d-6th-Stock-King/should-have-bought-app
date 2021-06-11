import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/buy_or_not/stock_hist.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';
import 'package:should_have_bought_app/models/card/chart_dto.dart';
import 'package:should_have_bought_app/models/drip_room/evaluation_item.dart';
import 'package:should_have_bought_app/screens/card/card_button.dart';
import 'package:should_have_bought_app/utils.dart';
import 'package:should_have_bought_app/widgets/appbar/card_appbar.dart';
import 'package:should_have_bought_app/widgets/card/lib/swipe_cards.dart';
import 'package:should_have_bought_app/widgets/chart/chart_wiget.dart';
import 'package:should_have_bought_app/providers/card/card_provider.dart';
import 'package:should_have_bought_app/widgets/login/login_handler.dart';

class CardScreen extends StatefulWidget {
  @override
  _CreateCardScreen createState() => _CreateCardScreen();
}

class _CreateCardScreen extends State<CardScreen> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future:
            Provider.of<CardProvider>(context, listen: false).getToDoEvalList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CardScreenWidget(data: snapshot.data);
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}

class CardScreenWidget extends StatefulWidget {
  List<ChartDto> data;

  CardScreenWidget({this.data});

  @override
  _CreateCardScreenWidget createState() => _CreateCardScreenWidget();
}

class _CreateCardScreenWidget extends State<CardScreenWidget>
    with TickerProviderStateMixin {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<SwipeItem> _swipeItems = [];
  MatchEngine _matchEngine;

  AnimationController _leftAniController;
  AnimationController _rightAniController;
  AnimationController _upAniController;
  bool leftVisible = false;
  bool rightVisible = false;
  bool upVisible = false;

  @override
  void initState() {
    List<ChartDto> cardList =
        Provider.of<CardProvider>(context, listen: false).cardList;
    _swipeItems = CreateSwipeItem(cardList);

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    _leftAniController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    _rightAniController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    _upAniController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _matchEngine.dispose();
    _leftAniController.dispose();
    _rightAniController.dispose();
    _upAniController.dispose();
    super.dispose();
  }

  List<SwipeItem> CreateSwipeItem(List<ChartDto> cardList) {
    return cardList.map<SwipeItem>((item) {
      return SwipeItem(
          content: item,
          likeAction: () {
            print('RIGHT');
            if (_auth.currentUser == null) {
              LoginHandler(context);
            } else {
              setState(() => rightVisible = true);
              Provider.of<CardProvider>(context, listen: false)
                  .setBuyOrNotStock(item.stockHist.code, 'SELL');
              _rightAniController.forward().then((_) {
                setState(() => rightVisible = false);
                _rightAniController.reset();
              });
            }
          },
          nopeAction: () {
            print('LEFT');
            if (_auth.currentUser == null) {
              LoginHandler(context);
            } else {
              setState(() => leftVisible = true);
              Provider.of<CardProvider>(context, listen: false)
                  .setBuyOrNotStock(item.stockHist.code, 'BUY');
              _leftAniController.forward().then((_) {
                setState(() => leftVisible = false);
                _leftAniController.reset();
              });
            }
          },
          superlikeAction: () {
            print('UP');
            if (_auth.currentUser == null) {
              LoginHandler(context);
            } else {
              Provider.of<CardProvider>(context, listen: false)
                  .setBuyOrNotStock(item.stockHist.code, 'NULL');
              setState(() => upVisible = true);
              _upAniController.forward().then((_) {
                setState(() => upVisible = false);
                _upAniController.reset();
              });
            }
          });
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: CardAppBar(context),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CardButton(
                        title: "살래",
                        icon: Image(
                            image:
                                AssetImage('assets/icons/ico_card_left.png')),
                        onPressed: () {
                          if (_auth.currentUser == null) {
                            LoginHandler(context);
                          } else {
                            print(_matchEngine.currentItem.content);
                            _matchEngine.currentItem.nope();
                          }
                        }),
                    CardButton(
                        title: "몰라",
                        icon: Image(
                            image: AssetImage('assets/icons/ico_card_up.png')),
                        onPressed: () {
                          if (_auth.currentUser == null) {
                            LoginHandler(context);
                          } else {
                            _matchEngine.currentItem.superLike();
                          }
                        }),
                    CardButton(
                        title: "말래",
                        icon: Image(
                            image:
                                AssetImage('assets/icons/ico_card_right.png')),
                        onPressed: () {
                          if (_auth.currentUser == null) {
                            LoginHandler(context);
                          } else {
                            _matchEngine.currentItem.like();
                          }
                        }),
                  ],
                )
              ]),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 240,
              child: SwipeCards(
                matchEngine: _matchEngine,
                itemBuilder: (BuildContext context, int index) {
                  return BuyOrNotCard(index);
                },
                onStackFinished: () async{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("카드가 없습니다."),
                    duration: Duration(milliseconds: 500),
                  ));
                  await EasyLoading.show(
                    status: 'loading...',
                    maskType: EasyLoadingMaskType.none,
                  );
                  final testss = await Provider.of<CardProvider>(context, listen: false).getToDoEvalList();
                  print('final');
                  print(testss);
                  List<SwipeItem> addCardList = CreateSwipeItem(testss);
                  print(addCardList);
                  setState(() {
                    _swipeItems = addCardList;
                    _matchEngine = MatchEngine(swipeItems: addCardList);
                  });
                  await EasyLoading.dismiss();
                  //_scaffoldKey.currentState.showSnackBar();
                },
              ),
            ),
            leftVisible
                ? Positioned(
                    bottom: MediaQuery.of(context).size.height / 4,
                    left: 0,
                    child: Lottie.asset(
                      'assets/lottie/o_animation.json',
                      width: 200,
                      height: 200,
                      controller: _leftAniController,
                    ),
                  )
                : Container(),
            upVisible
                ? Positioned(
                    top: 0,
                    left: MediaQuery.of(context).size.width / 4.5,
                    child: Lottie.asset(
                      'assets/lottie/null_animation.json',
                      width: 200,
                      height: 200,
                      controller: _upAniController,
                    ),
                  )
                : Container(),
            rightVisible
                ? Positioned(
                    bottom: MediaQuery.of(context).size.height / 4,
                    right: 0,
                    child: Lottie.asset(
                      'assets/lottie/x_animation.json',
                      width: 200,
                      height: 200,
                      controller: _rightAniController,
                    ),
                  )
                : Container(),
          ],
        ));
  }

  Widget BuyOrNotCard(int index) {
    StockHist _stockHist = _swipeItems[index].content.stockHist;
    EvaluationItem _evaluation = _swipeItems[index].content.evaluation;
    return Container(
      child: Card(
        elevation: 0.4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.33,
                    child: ChartWidget(_stockHist)),
                Container(
                  height: MediaQuery.of(context).size.height * 0.33,
                  color: Colors.transparent,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  DefaultTextStyle(
                    style: kCardTitleTextStyle,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          _stockHist?.company ?? '',
                          presetFontSizes: [20, 22],
                          maxLines: 1,
                        ),
                        //Text(_swipeItems[index].content?.company ??''),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          emojiIncreaseOrDecrease(
                              _stockHist?.changeInPercent ?? 0),
                          style: TextStyle(
                              fontSize: 12,
                              height: 2.5,
                              color: colorIncreaseOrDecrease(
                                  _stockHist?.changeInPercent ?? 0)),
                        ),
                        AutoSizeText(
                          '${numberWithComma(_stockHist?.price.toString() ?? '')}',
                          presetFontSizes: [20, 22],
                          maxLines: 1,
                          style: TextStyle(
                              color: colorIncreaseOrDecrease(
                                  _stockHist?.changeInPercent ?? 0)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _evaluation.id == null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: [
                              Container(
                                child: Text(
                                  '아직 작성된 드립이 없어요.',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, height: 2),
                                ),
                              ),
                              Container(
                                child: Text(
                                  '이 종목의 최초 드립 작성자가 되세요!',
                                  style: TextStyle(fontSize: 11),
                                ),
                              )
                            ],
                          ),
                        )
                      : DefaultTextStyle(
                          style: kCardContentTextStyle,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Card(
                                    color: Color(0xFFFF6258),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 7),
                                      child: Text('장점',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 8)),
                                  Text(_evaluation?.pros ?? '')
                                ],
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              //Divider(height: 2, color: Colors.grey,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Card(
                                    color: Color(0xFF5D99F2),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 7),
                                      child: Text('단점',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 8)),
                                  Text(_evaluation?.cons ?? ''),
                                ],
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
