import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/providers/card/card_provider.dart';
import 'package:should_have_bought_app/screens.dart';
import 'package:should_have_bought_app/utils.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';
import 'package:should_have_bought_app/widgets.dart';
import 'package:should_have_bought_app/widgets/appbar/default_appbar.dart';
import 'package:should_have_bought_app/widgets/hey_you_too/hey_you_too.dart';
import 'package:should_have_bought_app/widgets/main/current_stock_price_widget.dart';
import 'package:should_have_bought_app/widgets/main/header_widget.dart';
import 'package:should_have_bought_app/widgets/main/sell_at_this_time_widget.dart';
import 'package:should_have_bought_app/widgets/main/this_buy_or_not_widget.dart';
import 'package:should_have_bought_app/widgets/main/news_widget.dart';
import 'package:should_have_bought_app/widgets/today_word/today_word_best.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
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
          await Provider.of<CalculatorProvider>(context, listen: false)
              .getHistory();
        },
        child: ListView(
          children: [
            Frame(child: HeaderWidget()),
            SizedBox(height: 21), // add 계산기
            // TODO: 메인편집
            // Frame(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       Text("메인편집",
            //           style: TextStyle(
            //               fontSize: 14,
            //               fontWeight: FontWeight.w500,
            //               height: 1.5,
            //               color: mainColor)),
            //       //Icon(Icons.fiber_manual_record_rounded, color: Color(0xFF828282))
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 7,
            ),
            Frame(child: CalculatorWidget()),
            SizedBox(height: 50),
            Divider(thickness: 7, color: Color(0xFFF2F2F2)),
            SizedBox(height: 43),
            Frame(
              child: MainTitle(
                  title: "그때 살걸... 야, 너두?",
                  more: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HeyToYouMoreScreen()));
                  }),
            ),
            SizedBox(height: 16),
            HeyYouToo(),
            SizedBox(height: 50),
            Divider(thickness: 7, color: Color(0xFFF2F2F2)),
            SizedBox(height: 43),
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
                  // TODO: 종목선택
                  // Container(
                  //   padding: EdgeInsets.only(
                  //       left: 11, bottom: 2, top: 2, right: 3),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(40.0),
                  //     border: Border.all(
                  //       width: 1,
                  //       color: Color(0xFF828282),
                  //     ),
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text("종목선택",
                  //           style: TextStyle(
                  //               fontSize: 13,
                  //               fontWeight: FontWeight.w400,
                  //               height: 1.5,
                  //               color: Color(0xFF828282))),
                  //       Icon(Icons.keyboard_arrow_down_outlined,
                  //           color: Color(0xFF828282))
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            CurrentStockPriceWidget(),
            SizedBox(height: 50),
            Divider(thickness: 7, color: Color(0xFFF2F2F2)),
            SizedBox(height: 43),
            Frame(child: MainTitle(title: "오늘의 BEST 단어")),
            SizedBox(height: 23),
            Frame(child: TodayWordBest()),
            SizedBox(height: 51),
            Divider(thickness: 7, color: Color(0xFFF2F2F2)),
            SizedBox(height: 43),
            Frame(child: MainTitle(title: "이거 살까? 말까?")),
            SizedBox(height: 23),
            ThisBuyOrNotWidget(),
            Divider(thickness: 7, color: Color(0xFFF2F2F2)),
            SizedBox(height: 43),
            Frame(child: MainTitle(title: "이때 팔걸")),
            SizedBox(height: 23),
            SellAtThisTimeWidget(),
            SizedBox(height: 43),
            Divider(thickness: 7, color: Color(0xFFF2F2F2)),
            SizedBox(height: 43),
            Frame(child: MainTitle(title: "뉴스도 좀 보고 그래요")),
            SizedBox(height: 23),
            Frame(child: NewsWidget()),
            SizedBox(height: 43),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class MainTitle extends StatelessWidget {
  final String title;
  final VoidCallback more;
  MainTitle({@required this.title, this.more});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title ?? '',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        more == null
            ? Row()
            : InkWell(
                onTap: () {
                  more();
                },
                child: Row(
                  children: <Widget>[
                    Text('더보기'),
                    Icon(Icons.keyboard_arrow_right_outlined),
                  ],
                ),
              )
        //Icon(Icons.fiber_manual_record_rounded, color: Color(0xFF828282))
      ],
    );
  }
}
