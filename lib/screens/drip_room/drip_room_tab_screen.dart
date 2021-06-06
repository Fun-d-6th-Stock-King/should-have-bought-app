import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:should_have_bought_app/models/util/page_info.dart';
import 'package:should_have_bought_app/widgets/appbar/default_appbar.dart';
import 'package:should_have_bought_app/widgets/login/login_handler.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';
import 'package:should_have_bought_app/models/drip_room/evaluation_item.dart';
import 'package:should_have_bought_app/providers/drip_room/drip_room_provider.dart';
import 'package:should_have_bought_app/screens.dart';
import 'package:should_have_bought_app/screens/util/skeleton_widget.dart';
import 'package:should_have_bought_app/widgets/appbar/drip_room_appbar.dart';
import 'package:should_have_bought_app/screens/stock/stock_detail_screen.dart';
import 'package:should_have_bought_app/widgets/background/flat_background_frame.dart';
import 'package:should_have_bought_app/widgets/text/prod_and_cons_widget.dart';

class DripRoomTabScreen extends StatefulWidget {
  static const routeId = '/select-drip';
  @override
  _DripRoomTabScreenState createState() => _DripRoomTabScreenState();
}

class _DripRoomTabScreenState extends State<DripRoomTabScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool emojiShowing = false;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Map<String, dynamic> parmeters = {
      'order': 'POPULARITY',
      'pageNo': '1',
      'pageSize': '100'
    };

    bool isEmpty = Provider.of<DripRoomProvider>(context, listen: false)
                .evaluationItemList
                .length ==
            0
        ? true
        : false;
    if (isEmpty) {
      await EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.none,
      );
      Provider.of<DripRoomProvider>(context, listen: false)
          .getEvaluationList(parmeters)
          .then((value) => EasyLoading.dismiss());
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      body: SingleChildScrollView(
          child: Column(children: [
        SizedBox(height: 25),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          margin: const EdgeInsets.only(top: 10),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                "BEST",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(width: size.width * 0.55),
              Container(
                child: Row(
                  children: [
                    Text('오늘HOT'),
                    Icon(Icons.keyboard_arrow_down_outlined)
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
            height: size.height * 0.47,
            child: Consumer<DripRoomProvider>(
                child: emptyDripListRoomScreen(context),
                builder: (context, dripRoomProvider, child) {
                  List evaluationItemList = dripRoomProvider.evaluationItemList;
                  return dripRoomProvider.evaluationItemList.length == 0
                      ? child
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: evaluationItemList.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Container(
                            child: BestDripCardListWidget(
                                evaluationItemList[index]),
                          ),
                        );
                })),
        Consumer<DripRoomProvider>(
            child: emptyDripListRoomScreen(context),
            builder: (context, dripRoomProvider, child) {
              List evaluationItemList = dripRoomProvider.evaluationItemList;
              return dripRoomProvider.evaluationItemList.length == 0
                  ? child
                  : Column(children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
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
                          itemBuilder: (BuildContext context, int index) =>
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(children: [
                                    SizedBox(height: 10),
                                    Container(
                                      child: BestDripCardListWidget(
                                          evaluationItemList[index]),
                                    ),
                                    SizedBox(height: 15),
                                  ])))
                    ]);
            })
      ])),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: FloatingActionButton(
          backgroundColor: mainColor,
          onPressed: () => _showCreateDripBottomSheet(context),
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  // TODO: 등록 버튼 (정민님)
  void _showCreateDripBottomSheet(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        )),
        builder: (ctx) {
          return AnimatedPadding(
              duration: Duration(milliseconds: 150),
              curve: Curves.easeOut,
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                child: Container(
                  height: 750,
                  child: Column(
                    children: [
                      Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(top: 20),
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
                                  controller: _controller,
                                  showCursor: false,
                                  readOnly: true,
                                  style: const TextStyle(
                                      fontSize: 150.0, color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: '\u{1F601}',
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
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
                                  style:
                                      TextStyle(color: mainColor, fontSize: 15),
                                ),
                              ),
                            ),
                            bottom: -15,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.08,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xFFF7F7F7),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Color(0xFFFF8888),
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
                                margin: EdgeInsets.only(top: 5),
                                child: TextFormField(
                                  autofocus: false,
                                  showCursor: false,
                                  keyboardType: TextInputType.text,
                                  maxLength: 20,
                                  textAlignVertical: TextAlignVertical.center,
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
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xFFF7F7F7),
                        ),
                        child: Row(
                          children: [
                            Container(
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
                                  showCursor: false,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.text,
                                  maxLength: 20,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: new InputDecoration(
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
                        margin: EdgeInsets.only(top: 30),
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
                            // TODO: 등록로직 필요 (정민님)
                            onPressed: () => _auth.currentUser == null
                                ? LoginHandler(context)
                                : _registerFlow()),
                      ),
                      Offstage(
                        offstage: !emojiShowing,
                        child: SizedBox(
                          height: 250,
                          child: EmojiPicker(
                              onEmojiSelected:
                                  (Category category, Emoji emoji) {
                                _controller
                                  ..text = emoji.emoji
                                  ..selection = TextSelection.fromPosition(
                                      TextPosition(
                                          offset: _controller.text.length));
                              },
                              config: const Config(
                                  columns: 8,
                                  emojiSizeMax: 32.0,
                                  verticalSpacing: 0,
                                  horizontalSpacing: 0,
                                  initCategory: Category.RECENT,
                                  bgColor: Colors.white,
                                  iconColor: Colors.grey,
                                  showRecentsTab: true,
                                  recentsLimit: 28,
                                  noRecentsText: 'No Recents',
                                  noRecentsStyle: TextStyle(
                                      fontSize: 20, color: Colors.black26),
                                  categoryIcons: CategoryIcons(),
                                  buttonMode: ButtonMode.MATERIAL)),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }

  void _registerFlow() {}
}

class BestDripCardListWidget extends StatelessWidget {
  final EvaluationItem evaluationItem;

  BestDripCardListWidget(this.evaluationItem);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
              width: size.width * 0.9,
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 15, bottom: 15),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding:
                                EdgeInsets.only(left: size.width * 0.9 * 0.7),
                            child: Column(
                              children: [
                                Image(
                                    image: AssetImage(
                                        'assets/icons/ico_like.png')),
                                SizedBox(height: 2),
                                Text(
                                  evaluationItem.likeCount.toString(),
                                  style: TextStyle(
                                      fontSize: 11, color: Color(0xFF828282)),
                                ),
                              ],
                            )),
                        Text(
                          '\u{1F601}', //이모티콘
                          style: TextStyle(
                              fontSize: 80, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 13.0),
                        ),
                        Text(
                          evaluationItem?.displayName ?? '',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: 17 / 12),
                        ),
                        VerticalDivider(
                          color: Color(0xFF8E8E8E),
                          thickness: 0.6,
                        ),
                        Text(
                          evaluationItem?.createdDate ?? '',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w300,
                              color: Color(0xFF828282)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.only(left: 13.0),
                    child: ProsAndConsWidget(
                      pros: evaluationItem?.pros ?? '',
                      cons: evaluationItem?.cons ?? '',
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              )),
        ],
      ),
    );
  }
}

Widget emptyDripListRoomScreen(BuildContext context) {
  return Column(
    children: [
      SizedBox(height: 30),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('BEST'),
                Row(
                  children: [
                    Text('오늘HOT'),
                    Icon(Icons.keyboard_arrow_down_outlined)
                  ],
                ),
              ],
            ),
            SizedBox(height: 11),
            BestDripCardListWidget(EvaluationItem())
          ],
        ),
      )
    ],
  );
}
