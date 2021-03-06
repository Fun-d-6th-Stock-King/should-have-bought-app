import 'dart:math';
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
  void initState() {
    super.initState();
  }

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
                    Text('?????????'),
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
                "??????",
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _writeWord(BuildContext context) {
    final _topController = TextEditingController();
    final _bottomController = TextEditingController();
    bool writeLoading = false;
    _topController.addListener(() {});
    _bottomController.addListener(() {});

    @override
    void dispose() {
      _topController.dispose();
      _bottomController.dispose();
      super.dispose();
    }

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
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      child: Icon(
                        Icons.close,
                        size: 24,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '?????? ??????',
                      style: kWordWriteTitleStyle,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.0),
                      color: Color(0xFFF7F7F7),
                    ),
                    child: TextFormField(
                      controller: _topController,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (value.isEmpty) {
                          return '????????? ???????????????';
                        } else {
                          return null;
                        }
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(15),
                      ],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('?????? ??????', style: kWordWriteTitleStyle),
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
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(80),
                      ],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13.0),
                        color: mainColor,
                      ),
                      child: Center(
                        child: Text(
                          '?????? ??????',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    onTap: () async {
                      final topText = _topController?.text;
                      final bottomText = _bottomController?.text;
                      if (topText.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Text('?????? ????????? ??????????????????!'),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              )
                            ],
                          ),
                        );
                      } else if (bottomText.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Text('?????? ????????? ??????????????????!'),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              )
                            ],
                          ),
                        );
                      } else {
                        setState(() {
                          writeLoading = true;
                        });
                        await Provider.of<TodayWordProvider>(context,
                                listen: false)
                            .saveWord({
                          'wordName': _topController.text,
                          'mean': _bottomController.text,
                        }).then((value) {
                          setState(() {
                            writeLoading = false;
                          });
                        });
                        if (!writeLoading) {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}

/// ?????? ??????
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

/// ??????????????? ??????
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

/// ?????? ?????? ??????
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
        print("?????? ?????? ??????");
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
                            '${wordItem.displayName}${isMine ? '(???)' : ''}',
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
