import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/buy_or_not/stock_hist.dart';
import 'package:should_have_bought_app/models/drip_room/evaluation_item.dart';
import 'package:should_have_bought_app/screens/card/card_button.dart';
import 'package:should_have_bought_app/widgets/appbar/card_appbar.dart';
import 'package:should_have_bought_app/widgets/card/lib/swipe_cards.dart';
import 'package:should_have_bought_app/widgets/chart/chart_wiget.dart';
import 'package:should_have_bought_app/providers/card/card_provider.dart';

class CardScreen extends StatefulWidget {
  @override
  _CreateCardScreen createState() => _CreateCardScreen();
}

class _CreateCardScreen extends State<CardScreen> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await Provider.of<CardProvider>(context, listen: false).getToDoEvalList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future:
            Provider.of<CardProvider>(context, listen: false).getToDoEvalList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return CardScreenWidget();
          }
          return CircularProgressIndicator();
        });
  }
}

class CardScreenWidget extends StatefulWidget {
  @override
  _CreateCardScreenWidget createState() => _CreateCardScreenWidget();
}

class _CreateCardScreenWidget extends State<CardScreenWidget>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<SwipeItem> _swipeItems = List<SwipeItem>();
  MatchEngine _matchEngine;
  List<String> _names = ["삼성전자", "SK 하이닉스", "카카오", "현대자동차", "네이버"];
  List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange
  ];
  AnimationController _leftAniController;
  AnimationController _rightAniController;
  AnimationController _upAniController;
  bool leftVisible = false;
  bool rightVisible = false;
  bool upVisible = false;

  @override
  void initState() {
    for (int i = 0; i < _names.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(text: _names[i], color: _colors[i]),
          likeAction: () {
            print('RIGHT');
            setState(() => rightVisible = true);
            _rightAniController.forward().then((_) {
              setState(() => rightVisible = false);
              _rightAniController.reset();
            });
          },
          nopeAction: () {
            print('LEFT');
            setState(() => leftVisible = true);
            _leftAniController.forward().then((_) {
              setState(() => leftVisible = false);
              _leftAniController.reset();
            });
          },
          superlikeAction: () {
            print('UP');
            setState(() => upVisible = true);
            _upAniController.forward().then((_) {
              setState(() => upVisible = false);
              _upAniController.reset();
            });
          }));
    }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: CardAppBar(context),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom:100),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CardButton(
                        title: "살래",
                        icon: Image(
                            image: AssetImage('assets/icons/ico_card_left.png')),
                        onPressed: () {
                          _matchEngine.currentItem.nope();
                        }),
                    CardButton(
                        title: "몰라",
                        icon: Image(
                            image: AssetImage('assets/icons/ico_card_up.png')),
                        onPressed: () {
                          _matchEngine.currentItem.superLike();
                        }),
                    CardButton(
                        title: "말래",
                        icon: Image(
                            image: AssetImage('assets/icons/ico_card_right.png')),
                        onPressed: () {
                          _matchEngine.currentItem.like();
                        }),
                  ],
                )
              ]),
            ),
            Container(
              height: MediaQuery.of(context).size.height-240,
              child: SwipeCards(
                matchEngine: _matchEngine,
                itemBuilder: (BuildContext context, int index) {
                  return BuyOrNotCard(index);
                },
                onStackFinished: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("카드가 없습니다."),
                    duration: Duration(milliseconds: 500),
                  ));
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
    return Container(
      child: Card(
        elevation: 0.4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.25,
                child: ChartWidget()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  DefaultTextStyle(
                    style: kCardTitleTextStyle,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(_swipeItems[index].content.text),
                        Padding(padding: EdgeInsets.only(left: 7)),
                        Text(
                          '▼ 82,600',
                          style: TextStyle(color: Color(0xFF5D99F2)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DefaultTextStyle(
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
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 7),
                                child: Text('장점',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(left: 8)),
                            Text('망해도 국가가 살려줄 국민주')
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        //Divider(height: 2, color: Colors.grey,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Card(
                              color: Color(0xFF5D99F2),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 7),
                                child: Text('단점',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(left: 8)),
                            Text('내가 벌때 쟤도 범'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  MediaQuery.of(context).size.height > 610
                      ? SizedBox(height: 10)
                      : SizedBox(height: 1),
                  Text(
                    '더보기 >',
                    style: TextStyle(fontSize: 16, color: Color(0xFF8C8C8C)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Content {
  final String text;
  final Color color;

  Content({this.text, this.color});
}
