import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/providers/buy_or_not/buy_or_not_provider.dart';
import 'package:should_have_bought_app/widgets/card/lib/swipe_cards.dart';
import 'package:should_have_bought_app/widgets/chart/chart_wiget.dart';

class CardScreen extends StatefulWidget {
  @override
  _CreateCardScreen createState() => _CreateCardScreen();
}

class _CreateCardScreen extends State<CardScreen> {
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

  @override
  void initState() {
    for (int i = 0; i < _names.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(text: _names[i], color: _colors[i]),
          likeAction: () {
            print('LEFT');
            // _scaffoldKey.currentState.showSnackBar(SnackBar(
            //   content: Text("Liked ${_names[i]}"),
            //   duration: Duration(milliseconds: 500),
            // ));
          },
          nopeAction: () {
            print('UP');
            // ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(
            //       content: Text("Nope ${_names[i]}"),
            //       duration: Duration(milliseconds: 500),
            //     )
            // );
            // _scaffoldKey.currentState.showSnackBar();
          },
          superlikeAction: () {
            print('RIGHT');
            // _scaffoldKey.currentState.showSnackBar(SnackBar(
            //   content: Text("Superliked ${_names[i]}"),
            //   duration: Duration(milliseconds: 500),
            // ));
          }));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //Provider.of<BuyOrNotProvider>(context, listen: false).getEvaluationLists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
            child: Column(children: [
              Container(
                child: SwipeCards(
                  matchEngine: _matchEngine,
                  itemBuilder: (BuildContext context, int index) {
                    return BuyOrNotCard(index);
                  },
                  onStackFinished: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Stack Finished"),
                          duration: Duration(milliseconds: 500),
                        )
                    );
                    //_scaffoldKey.currentState.showSnackBar();
                  },
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     RaisedButton(
              //         onPressed: () {
              //           _matchEngine.currentItem.nope();
              //         },
              //         child: Text("Nope")),
              //     RaisedButton(
              //         onPressed: () {
              //           _matchEngine.currentItem.superLike();
              //         },
              //         child: Text("Superlike")),
              //     RaisedButton(
              //         onPressed: () {
              //           _matchEngine.currentItem.like();
              //         },
              //         child: Text("Like"))
              //   ],
              // )
            ])));
  }

  Widget BuyOrNotCard(int index) {
    return Container(
      height: 500,
      child: Card(
        elevation: 0.4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('2021.03.10. 13:54')
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    // backgroundImage: NetworkImage(
                    //     'https://www.woolha.com/media/2020/03/eevee.png'),
                    backgroundColor: Colors.grey,
                  ),
                  Padding(padding: EdgeInsets.only(left: 7)),
                  Text(_swipeItems[index].content.text, style:TextStyle(fontSize: 30)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('▼ 82,600', style: TextStyle(
                    fontSize: 26,
                    color: Color(0xFF5D99F2)
                  ),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('(-1.55%)'),
                ],
              ),
              Container(
                  height: 250,
                  child: ChartWidget()
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: Color(0xFFFF8888),
                    padding: EdgeInsets.symmetric(horizontal: 7),
                    child: Text('장점', style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    )),
                  ),
                  Padding(padding: EdgeInsets.only(left: 14)),
                  Text('망해도 국가가 살려줄 국민주',style: TextStyle(
                    fontSize: 20,)),
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Divider(height: 2, color: Colors.grey,),
              SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: Color(0xFF5D99F2),
                    padding: EdgeInsets.symmetric(horizontal: 7),
                    child: Text('단점', style: TextStyle(
                      fontSize: 20,
                    color: Colors.white
                    )),
                  ),
                  Padding(padding: EdgeInsets.only(left: 14)),
                  Text('내가 벌때 쟤도 범',style: TextStyle(
                    fontSize: 20,)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text('더보기 >',style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF8C8C8C)
              ),)
            ],
          ),
          // child: Container(
          //   alignment: Alignment.center,
          //   child: Text(
          //     _swipeItems[index].content.text,
          //     style: TextStyle(fontSize: 100),
          //   ),
          // ),
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

