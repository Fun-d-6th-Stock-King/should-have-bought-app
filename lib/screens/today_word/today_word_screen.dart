import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/screens.dart';
import 'package:should_have_bought_app/screens/main/example/example.dart';
import 'package:should_have_bought_app/widgets/appbar/default_appbar.dart';
import 'package:should_have_bought_app/widgets/login/login_handler.dart';
import 'package:should_have_bought_app/widgets/login/login_widget.dart';
import 'package:should_have_bought_app/widgets/util/loading/loading_widget.dart';

class TodayWordScreen extends StatefulWidget {
  @override
  _TodayWordScreenState createState() => _TodayWordScreenState();
}

class _TodayWordScreenState extends State<TodayWordScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(context),
      body: Example(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: FloatingActionButton(
          backgroundColor: mainColor,
          onPressed: () => _showCreateWordBottomSheet(context),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
   // TODO: 등록 버튼 (정민님)
  void _showCreateWordBottomSheet(BuildContext context) async {
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
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                height: 300,
                child: Column(children: [
                  Container(
                    child: Text('hello'),
                  ),
                  Container(
                    height: 50,
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
                        onPressed: () => _auth.currentUser == null ? LoginHandler(context) : _registerFlow()),
                  ),
                ]),
              ));
        });
  }
  void _registerFlow() {

  }
}
