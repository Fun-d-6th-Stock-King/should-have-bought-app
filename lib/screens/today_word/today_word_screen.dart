import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/screens.dart';
import 'package:should_have_bought_app/widgets/login/login_widget.dart';

class TodayWordScreen extends StatefulWidget {
  @override
  _TodayWordScreenState createState() => _TodayWordScreenState();
}

class _TodayWordScreenState extends State<TodayWordScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    test();
  }

  void test() async {
    final user = await _auth.currentUser;
    print(user);
    if (user != null) {
      final idToken = await user.getIdToken();
      print(idToken);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Text('TodayWordScreen'),
          ),
        ],
      ),
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
                        onPressed: () => _showLoginBottomSheet(context)),
                  ),
                ]),
              ));
        });
  }

  void _showLoginBottomSheet(BuildContext context) async {
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
                height: 200,
                child: _handleCurrentScreen()),
          );
        });
  }

  Widget _handleCurrentScreen() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print('[TEST] login');
          print(snapshot.hasData);
          print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              print(snapshot.data);
              //Provider.of<UserCredentialProvider>(context, listen: false).setFirebaseUser(snapshot.data);
            }
          }
          return LoginWidget();
        });
  }
}
