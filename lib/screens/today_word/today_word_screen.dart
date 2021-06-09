import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/models/today_word/word_item.dart';
import 'package:should_have_bought_app/providers/today_word/today_word_provider.dart';
import 'package:should_have_bought_app/screens.dart';
import 'package:should_have_bought_app/utils.dart';
import 'package:should_have_bought_app/widgets/appbar/today_word_appbar.dart';
import 'package:should_have_bought_app/widgets/background/flat_background_frame.dart';
import 'package:should_have_bought_app/widgets/login/login_handler.dart';

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

    Provider.of<TodayWordProvider>(context, listen: false)
        .getWordList(parmeters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      body: Consumer<TodayWordProvider>(
          builder: (context, todayWordProvider, child) {
        var wordItemList = todayWordProvider.wordItemList;
        var isLoading = todayWordProvider.isLoading;
        return SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              FlatBackgroundFrame(child: _HeaderWidget()),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('최신순'),
                    Icon(Icons.keyboard_arrow_down_outlined)
                  ],
                ),
              ),
              ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: wordItemList.length,
                  itemBuilder: (context, index) {
                    return WordCardWidget(wordItemList[index], _auth);
                  }),
              SizedBox(height: 80)
            ],
          ),
        );
      }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: FloatingActionButton(
          backgroundColor: mainColor,
          onPressed: () => _auth.currentUser == null
              ? LoginHandler(context)
              : _writeWord(context),
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

  _writeWord(BuildContext context) {
    TextEditingController _topController;
    TextEditingController _bottomController;

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        )),
        builder: (ctx) {
          return Container(
            height: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              color: Colors.white,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.exit_to_app_sharp),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '단어 이름',
                      style: kWordWriteTitleStyle,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.0),
                      color: Color(0xFFF7F7F7),
                    ),
                    child: TextFormField(
                      controller: _topController,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (value.isEmpty) {
                          return '단어를 입력하세요';
                        } else {
                          return null;
                        }
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(15),
                      ],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('단어 내용', style: kWordWriteTitleStyle),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.0),
                      color: Color(0xFFF7F7F7),
                    ),
                    child: TextField(
                      controller: _bottomController,
                      autofocus: true,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 4,
                      maxLength: 80,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        border: InputBorder.none,
                        counterStyle: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 23),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.0),
                      color: mainColor,
                    ),
                    child: Center(
                      child: Text(
                        '작성 완료',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
    // var parmeters = <String, dynamic>{
    //   'order': 'LATELY',
    //   'pageNo': '1',
    //   'pageSize': '100'
    // };
    //     .getWordList(parmeters);
    // Provider.of<TodayWordProvider>(context, listen: false).getMore();
  }
}

/// 헤더 위젯
class _HeaderWidget extends StatelessWidget {
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
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
        borderRadius: BorderRadius.circular(16),
      ),
      child: Consumer<TodayWordProvider>(
          builder: (context, todayWordProvider, child) {
        var wordItem = todayWordProvider.todayBest;
        var isLoading = todayWordProvider.isLoading;
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
                          wordItem.displayName,
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
                          wordItem.createdDateText,
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
                    InkWell(
                      onTap: () => _auth.currentUser == null
                          ? LoginHandler(context)
                          : Provider.of<TodayWordProvider>(context,
                                  listen: false)
                              .likeWord(wordItem),
                      child: SizedBox(
                        width: 36,
                        height: 36,
                        child: ClipOval(
                          child: Container(
                            color: wordItem.userlike ? mainColor : kGreyColor,
                            child: Image(
                                image:
                                    AssetImage('assets/icons/ico_heart.png')),
                          ),
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
                Text(commonDayDateFormat(wordItem.createdDate)),
              ],
            )
          ],
        );
      }),
    );
  }

// _likeWord(WordItem wordItem) {
//   EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
//   Provider.of<TodayWordProvider>(context, listen: false)
//       .likeWord(wordItem.id)
//       .then((value) {
//     wordItem.userlike = !wordItem.userlike;
//     if (wordItem.userlike) {
//       wordItem.likeCount += 1;
//     } else {
//       wordItem.likeCount -= 1;
//     }
//     EasyLoading.dismiss();
//   });
// }
}

/// 단어 카드 위젯
class WordCardWidget extends StatelessWidget {
  final WordItem wordItem;
  final FirebaseAuth _auth;
  bool isMine;

  WordCardWidget(this.wordItem, this._auth) {
    isMine = _auth?.currentUser?.uid == wordItem.createdUid;
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return InkWell(
      onTap: () {
        print("단어 카드 위젯");
        // Navigator.push(context, MaterialPageRoute(builder: (context) => StockDetailScreen(wordItem,1)));
      },
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 26),
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
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
                            '${wordItem.displayName}${isMine ? '(나)' : ''}',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                height: 20 / 14,
                                color: isMine ? mainColor : Color(0xFF333333)),
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
                            wordItem.createdDateText,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 20 / 14,
                                color: kDateColor),
                          ),
                        ],
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: mediaQuery.size.width * 0.6,
                        ),
                        child: Text(
                          wordItem.wordName ?? '',
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              height: 17 / 12),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () => _auth.currentUser == null
                            ? LoginHandler(context)
                            : Provider.of<TodayWordProvider>(context,
                                    listen: false)
                                .likeWord(wordItem),
                        child: SizedBox(
                          width: 36,
                          height: 36,
                          child: ClipOval(
                            child: Container(
                              color: wordItem.userlike ? mainColor : kGreyColor,
                              child: Image(
                                  image:
                                      AssetImage('assets/icons/ico_heart.png')),
                            ),
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
              Text(
                wordItem.mean,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(commonDayDateFormat(wordItem.createdDate),
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
