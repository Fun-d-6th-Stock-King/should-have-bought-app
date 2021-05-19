import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/providers/today_word/today_word_provider.dart';
import 'package:should_have_bought_app/widgets/appbar/today_word_appbar.dart';
import 'package:should_have_bought_app/widgets/background/flat_background_frame.dart';

class TodayWordScreen extends StatefulWidget {
  @override
  _TodayWordScreenState createState() => _TodayWordScreenState();
}

class _TodayWordScreenState extends State<TodayWordScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var parmeters = <String, dynamic>{'order':'LATELY','pageNo':'1','pageSize':'100'};
    var isEmpty = Provider.of<TodayWordProvider>(context, listen:false).wordItemList.isEmpty ? true : false;
    if(isEmpty) {
      Provider.of<TodayWordProvider>(context, listen: false).getWordList(parmeters);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      body: Consumer<TodayWordProvider>(
          builder: (context, todayWordProvider, child) {
            var wordItemList = todayWordProvider.wordItemList;
            return Container(
              margin:EdgeInsets.only(bottom: 100),
              child: ListView.builder(
                  itemCount: wordItemList.length,
                  itemBuilder: (context, index) {
                    // if(index == 0) {
                      return Column(
                        children: [
                          FlatBackgroundFrame(
                              child: HeaderWidget()
                          ),
                          SizedBox(height: 37),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('최신순'),
                                    Icon(Icons.keyboard_arrow_down_outlined)
                                  ],
                                ),
                                SizedBox(height: 11),
                                // DripCardWidget(wordItemList[index])
                              ],
                            ),
                          )
                        ],
                      );
                    // }
                    // return Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 16),
                    //   child: DripCardWidget(wordItemList[index]),
                    // );
                  }
              ),
            );
          }
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 100.0),
      //   child: FloatingActionButton(
      //     backgroundColor: mainColor,
      //     // onPressed: () => _showCreateWordBottomSheet(context),
      //     child: Icon(Icons.add),
      //   ),
      // ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          TodayWordAppBar(context),
          SizedBox(height: 33),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Today's BEST",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 9),
          BestWordWidget(),
        ],
      ),
    );
  }
}

class BestWordWidget extends StatefulWidget {
  @override
  _CreateBestWordWidgetState createState() => _CreateBestWordWidgetState();
}

class _CreateBestWordWidgetState extends State<BestWordWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<TodayWordProvider>(context, listen: false).getTodayBest();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Consumer<TodayWordProvider>(
          builder: (context, todayWordProvider, child) {
        var wordItem = todayWordProvider.todayBest;
        // EvaluationItem evaluationItem = BestWordProvider.todayBest;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 13.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wordItem.wordName ?? '',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        wordItem.wordName ?? '',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 17 / 12),
                      ),
                      Text(
                        wordItem.wordName ?? '',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                            color: Color(0xFF828282)),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 9),
            Divider(
              color: Color(0xFF8E8E8E),
              thickness: 0.6,
            ),
            SizedBox(height: 9)
          ],
        );
      }),
    );
  }
}
