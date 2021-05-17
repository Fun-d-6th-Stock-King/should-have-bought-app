import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/providers/buy_or_not/buy_or_not_provider.dart';
import 'package:should_have_bought_app/widgets/login/login_widget.dart';
import 'package:should_have_bought_app/widgets/util/loading/loading_widget.dart';

void LoginHandler(BuildContext context, {String buyOrNotStockCode}) {
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
        return AnimatedPadding(
          duration: Duration(milliseconds: 150),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              height: 200,
              child: _handleLogin()),
        );
      });
  future.then((void value) {
    if(buyOrNotStockCode != null) {
      Provider.of<BuyOrNotProvider>(context, listen: false).getBuyOrNotStock(
          buyOrNotStockCode);
    }
  });
}

Widget _handleLogin() {
  return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print(snapshot.hasData);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingWidget();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            print(snapshot.data);
          }
        }
        return LoginWidget();
  });
}