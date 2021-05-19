import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/utils.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';
import 'package:should_have_bought_app/widgets.dart';
import 'package:should_have_bought_app/widgets/appbar/default_appbar.dart';
import 'package:should_have_bought_app/widgets/hey_you_too/hey_you_too.dart';
import 'package:should_have_bought_app/widgets/main/current_stock_price_widget.dart';
import 'package:should_have_bought_app/widgets/main/header_widget.dart';
import 'package:should_have_bought_app/widgets/today_word/today_word_best.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> historyList;

  @override
  void initState() {
    Provider.of<CalculatorProvider>(context, listen: false).getHistory();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: DefaultAppBar(context),
      body: RefreshIndicator(
        onRefresh: () async {
          Provider.of<CalculatorProvider>(context, listen: false)
              .getHistory()
              .then(
                (value) => {
                  historyList =
                      Provider.of<CalculatorProvider>(context, listen: false)
                          .calculateHistory
                },
              );
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Frame(child: HeaderWidget()),
                  SizedBox(
                    height: 21,
                  ),
                  // add 계산기
                  Frame(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("메인편집",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                color: mainColor)),
                        //Icon(Icons.fiber_manual_record_rounded, color: Color(0xFF828282))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Frame(child: CalculatorWidget()),
                  SizedBox(
                    height: 50,
                  ),
                  Divider(thickness: 7, color: Color(0xFFF2F2F2)),
                  SizedBox(
                    height: 43,
                  ),
                  Frame(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "그때 살걸... 야, 너두?",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Text('더보기'),
                            Icon(Icons.keyboard_arrow_right_outlined),
                          ],
                        )
                        //Icon(Icons.fiber_manual_record_rounded, color: Color(0xFF828282))
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  HeyYouToo(),
                  SizedBox(
                    height: 50,
                  ),
                  Divider(thickness: 7, color: Color(0xFFF2F2F2)),
                  SizedBox(
                    height: 43,
                  ),
                  Frame(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("현재 주가",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              height: 1.5,
                            )),
                        Container(
                          padding: EdgeInsets.only(
                              left: 11, bottom: 2, top: 2, right: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            border: Border.all(
                              width: 1,
                              color: Color(0xFF828282),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("종목선택",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5,
                                      color: Color(0xFF828282))),
                              Icon(Icons.keyboard_arrow_down_outlined,
                                  color: Color(0xFF828282))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  CurrentStockPriceWidget(),
                  SizedBox(
                    height: 50,
                  ),
                  Divider(thickness: 7, color: Color(0xFFF2F2F2)),
                  SizedBox(
                    height: 43,
                  ),
                  Frame(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "오늘의 BEST 단어",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        //Icon(Icons.fiber_manual_record_rounded, color: Color(0xFF828282))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 23,
                  ),
                  Frame(child: TodayWordBest()),
                  SizedBox(
                    height: 51,
                  ),
                  Divider(thickness: 7, color: Color(0xFFF2F2F2)),
                  SizedBox(
                    height: 43,
                  ),
                  Frame(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "이거 살까? 말까?",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Text('더보기'),
                            Icon(Icons.keyboard_arrow_right_outlined),
                          ],
                        )
                        //Icon(Icons.fiber_manual_record_rounded, color: Color(0xFF828282))
                      ],
                    ),
                  ),
                  SizedBox(
                      height: 164,
                      child: Card(
                        elevation: 0.4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.0),
                          child: Container(),
                        ),
                      )),
                  SizedBox(
                    height: 66,
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
