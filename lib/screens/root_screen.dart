import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:should_have_bought_app/screens.dart' show LoadingScreen, TabScreen, LoginScreen;

class RootScreen extends StatefulWidget {
  @override
  _CreateRootScreenState createState() => _CreateRootScreenState();

}

class _CreateRootScreenState extends State<RootScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('root screen created');
    return Scaffold(
        backgroundColor: Colors.transparent,
        body:_handleCurrentScreen()
    );
  }

  Widget _handleCurrentScreen() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print('[TEST] login');
          print(snapshot.data);
          if(snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          }
          if(snapshot.hasData) {
            return TabScreen();
          }
          return LoginScreen();
        });
  }
}