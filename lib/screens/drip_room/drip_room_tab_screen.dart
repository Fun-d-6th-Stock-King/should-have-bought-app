import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:should_have_bought_app/models/buy_or_not/stock_evaluation_item.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';

import 'package:should_have_bought_app/widgets/login/login_handler.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/providers/drip_room/drip_room_provider.dart';
import 'package:should_have_bought_app/widgets/text/prod_and_cons_widget.dart';
import 'package:should_have_bought_app/widgets/drip_room/emoji_drip_card_widget.dart';

class DripRoomTabScreen extends StatefulWidget {
  static const routeId = '/select-drip';
  final Company company;
  DripRoomTabScreen(this.company);
  @override
  _DripRoomTabScreenState createState() => _DripRoomTabScreenState();
}

class _DripRoomTabScreenState extends State<DripRoomTabScreen> {
  final TextEditingController _cons = TextEditingController();
  final TextEditingController _pros = TextEditingController();
  final TextEditingController _giphyImgId = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool emojiShowing = false;
  bool isLoading = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _cons.dispose();
    _pros.dispose();
    _giphyImgId.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    setState(() {
      isLoading = true;
    });

    if (isLoading) {
      await EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.none,
      );
      await Provider.of<DripRoomProvider>(context, listen: false)
          .getBestEvaluateList(1, 3, 'MONTH12', widget.company.code);
      await Provider.of<DripRoomProvider>(context, listen: false)
          .getStockEvaluateList(1, 100, 'LATELY', widget.company.code)
          .then((value) => EasyLoading.dismiss());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "BEST",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text('전체 Hot'),
                        Icon(Icons.keyboard_arrow_down_outlined)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.45,
              child: Consumer<DripRoomProvider>(
                child: emptyDripListRoomScreen(context, _auth),
                builder: (context, dripRoomProvider, child) {
                  List evaluationItemList =
                      dripRoomProvider.bestStockEvaluationList.evaluationList;
                  return evaluationItemList == null
                      ? child
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: evaluationItemList.length,
                          itemBuilder: (context, index) => Container(
                            child: EmojiDripCardWidget(
                              evaluationItemList[index],
                              _auth,
                            ),
                          ),
                        );
                },
              ),
            ),
            Consumer<DripRoomProvider>(
              child: emptyDripListRoomScreen(context, _auth),
              builder: (context, dripRoomProvider, child) {
                List evaluationItemList =
                    dripRoomProvider.stockEvaluationList.evaluationList;
                return evaluationItemList == null
                    ? child
                    : Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Text(
                                  "전체",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal),
                                ),
                                SizedBox(width: 5),
                                Text(evaluationItemList.length.toString()),
                              ],
                            ),
                          ),
                          ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: evaluationItemList.length,
                            itemBuilder: (context, index) => Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: EmojiDripCardWidget(
                                evaluationItemList[index],
                                _auth,
                              ),
                            ),
                          ),
                        ],
                      );
              },
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton(
          backgroundColor: mainColor,
          onPressed: () {
            _showCreateDripSheet(context);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void _showCreateDripSheet(BuildContext context) {
    var heightOfModalBottomSheet = 450.0;
    var clickCount = 0;
    Future<void> future = showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        )),
        builder: (ctx) {
          emojiShowing = false;
          heightOfModalBottomSheet = 450.0;
          return StatefulBuilder(builder: (context, setState) {
            return SingleChildScrollView(
                child: AnimatedPadding(
                    padding: MediaQuery.of(context).viewInsets,
                    duration: Duration(milliseconds: 150),
                    curve: Curves.easeOut,
                    child: Container(
                      child: Container(
                        height: heightOfModalBottomSheet,
                        child: Column(
                          children: [
                            Stack(
                              overflow: Overflow.visible,
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(top: 25),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(
                                          color: mainColor,
                                          width: 2,
                                        )),
                                    width: 200,
                                    height: 200,
                                    alignment: Alignment.center,
                                    child: TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: _giphyImgId,
                                        showCursor: false,
                                        readOnly: true,
                                        style: const TextStyle(
                                            fontSize: 120.0,
                                            color: Colors.white),
                                        decoration: InputDecoration(
                                          hintText: '\u{1F601}',
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                        ))),
                                Positioned(
                                  left: 70,
                                  right: 70,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      setState(() {
                                        emojiShowing = !emojiShowing;
                                        clickCount += 1;
                                        if (clickCount == 1) {
                                          heightOfModalBottomSheet += 150;
                                        } else {
                                          clickCount = 0;
                                          heightOfModalBottomSheet -= 150;
                                        }
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: mainColor,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Text(
                                        '변경',
                                        style: TextStyle(
                                            color: mainColor, fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  bottom: -15,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.08,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xFFF7F7F7),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: Color(0xFFFF8888), //0xFFFF8888
                                    ),
                                    child: Text(
                                      '장점',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          height: 17 / 20,
                                          color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(width: 11),
                                  Expanded(
                                    child: Container(
                                      child: TextFormField(
                                        controller: _pros,
                                        autofocus: false,
                                        showCursor: false,
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.text,
                                        maxLength: 20,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            hintText: "장점을 입력하세요 (최대 20자)"),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          height: 10 / 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.08,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xFFF7F7F7),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: Color(0xFF5D99F2),
                                    ),
                                    child: Text(
                                      '단점',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          height: 17 / 20,
                                          color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(width: 11),
                                  Expanded(
                                    child: Container(
                                      child: TextFormField(
                                        autofocus: false,
                                        showCursor: true,
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.text,
                                        maxLength: 20,
                                        controller: _cons,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            hintText: "단점을 입력하세요 (최대 20자)"),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          height: 10 / 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              margin: EdgeInsets.only(top: 15),
                              width: MediaQuery.of(context).size.width,
                              child: CupertinoButton(
                                color: mainColor,
                                padding: EdgeInsets.all(0),
                                child: Text(
                                  '등록하기',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: defaultFontColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onPressed: () async {
                                  Map data = {
                                    'pros': _pros.text,
                                    'cons': _cons.text,
                                    'giphyImgId': _giphyImgId.text,
                                    'code': widget.company.code,
                                  };
                                  _auth.currentUser == null
                                      ? LoginHandler(context)
                                      : Provider.of<DripRoomProvider>(context,
                                              listen: false)
                                          .dripSave(data);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            Offstage(
                              offstage: !emojiShowing,
                              child: SizedBox(
                                height: 130,
                                child: EmojiPicker(
                                    onEmojiSelected:
                                        (Category category, Emoji emoji) {
                                      _giphyImgId
                                        ..text = emoji.emoji
                                        ..selection =
                                            TextSelection.fromPosition(
                                                TextPosition(
                                                    offset: _giphyImgId
                                                        .text.length));
                                    },
                                    config: const Config(
                                        columns: 10,
                                        emojiSizeMax: 20.0,
                                        verticalSpacing: 0,
                                        horizontalSpacing: 0,
                                        initCategory: Category.RECENT,
                                        bgColor: Colors.white,
                                        iconColor: Colors.grey,
                                        showRecentsTab: true,
                                        recentsLimit: 30,
                                        noRecentsText: 'No Recents',
                                        noRecentsStyle: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black26),
                                        categoryIcons: CategoryIcons(),
                                        buttonMode: ButtonMode.MATERIAL)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )));
          });
        });
    future.then((value) {
      Provider.of<DripRoomProvider>(context, listen: false).setIsSaved(true);
    });
  }
}

Widget emptyDripListRoomScreen(BuildContext context, FirebaseAuth auth) {
  return Column(
    children: [
      SizedBox(height: 30),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('BEST'),
                Row(
                  children: [
                    Text('전체 Hot'),
                    Icon(Icons.keyboard_arrow_down_outlined)
                  ],
                ),
              ],
            ),
            SizedBox(height: 11),
            EmojiDripCardWidget(StockEvaluationItem(), auth)
          ],
        ),
      )
    ],
  );
}
