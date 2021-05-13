import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/widgets/appbar/default_appbar.dart';
import 'package:should_have_bought_app/widgets/login/login_handler.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class SelectDripScreen extends StatefulWidget {
  static const routeId = '/select-drip';
  @override
  _SelectDripScreenState createState() => _SelectDripScreenState();
}

class _SelectDripScreenState extends State<SelectDripScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _controller = TextEditingController();

  bool emojiShowing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: DefaultAppBar(context),
      body: Container(
        child: Text('hello'),
      ),
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
                                  decoration: new InputDecoration(
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
