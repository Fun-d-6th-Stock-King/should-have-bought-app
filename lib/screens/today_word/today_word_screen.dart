import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/models/today_word/word_item.dart';
import 'package:should_have_bought_app/providers/today_word/today_word_provider.dart';
import 'package:should_have_bought_app/widgets/appbar/today_word_appbar.dart';
import 'package:should_have_bought_app/widgets/background/flat_background_frame.dart';

import '../../constant.dart';

class TodayWordScreen extends StatefulWidget {
  @override
  _TodayWordScreenState createState() => _TodayWordScreenState();
}

class _TodayWordScreenState extends State<TodayWordScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var parmeters = <String, dynamic>{
      'order': 'LATELY',
      'pageNo': '1',
      'pageSize': '100'
    };
    var isEmpty = Provider.of<TodayWordProvider>(context, listen: false)
            .wordItemList
            .isEmpty
        ? true
        : false;
    if (isEmpty) {
      Provider.of<TodayWordProvider>(context, listen: false)
          .getWordList(parmeters);
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
          margin: EdgeInsets.only(bottom: 100),
          child: ListView.builder(
              itemCount: wordItemList.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    children: [
                      FlatBackgroundFrame(child: HeaderWidget()),
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
                            WordCardWidget(wordItemList[index])
                          ],
                        ),
                      )
                    ],
                  );
                }
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: WordCardWidget(wordItemList[index]),
                );
              }),
        );
      }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: FloatingActionButton(
          backgroundColor: mainColor,
          // onPressed: () => _showCreateWordBottomSheet(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/icons/ico_write.png')),
              Text(
                "작성",
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// 헤더 위젯
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

/// 베스트단어 위젯
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
      padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Consumer<TodayWordProvider>(
          builder: (context, todayWordProvider, child) {
        var wordItem = todayWordProvider.todayBest;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '닉네임123',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              height: 20 / 14,
                              color: Color(0xFF333333)),
                        ),
                        SizedBox(width: 2),
                        Text(
                          '|',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 20 / 14,
                              color: Color(0xFF828282)),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '2일전',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: 20 / 14,
                              color: Color(0xFF828282)),
                        ),
                      ],
                    ),
                    Text(
                      wordItem.wordName ?? '',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          height: 17 / 12),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 36,
                      height: 36,
                      child: ClipOval(
                        child: Container(
                          color: mainColor,
                          child: Image(
                              image: AssetImage('assets/icons/ico_heart.png')),
                        ),
                      ),
                    ),
                    Text(wordItem.likeCount.toString(),
                        style: TextStyle(
                            color: mainColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w800)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 9),
            Text(wordItem.mean),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(wordItem.createdDate?.substring(0, 10)),
              ],
            )
          ],
        );
      }),
    );
  }
}

/// 단어 카드 위젯
class WordCardWidget extends StatelessWidget {
  final WordItem wordItem;
  WordCardWidget(this.wordItem);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => StockDetailScreen(wordItem,1)));
      },
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 26),
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '닉네임',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                height: 20 / 14,
                                color: Color(0xFF333333)),
                          ),
                          SizedBox(width: 2),
                          Text(
                            '|',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 20 / 14,
                                color: Color(0xFF828282)),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            '2일전',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 20 / 14,
                                color: kDateColor),
                          ),
                        ],
                      ),
                      Text(
                        wordItem.wordName ?? '',
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            height: 17 / 12),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 36,
                        height: 36,
                        child: ClipOval(
                          child: Container(
                            color: mainColor,
                            child: Image(
                                image:
                                    AssetImage('assets/icons/ico_heart.png')),
                          ),
                        ),
                      ),
                      Text(wordItem.likeCount.toString(),
                          style: TextStyle(
                              color: mainColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 9),
              Text(wordItem.mean),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                      wordItem.createdDate.isNotEmpty
                          ? wordItem.createdDate.substring(0, 10)
                          : '',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 20 / 14,
                          color: Color(0xFF828282))),
                ],
              )
            ],
          )),
    );
  }
}
