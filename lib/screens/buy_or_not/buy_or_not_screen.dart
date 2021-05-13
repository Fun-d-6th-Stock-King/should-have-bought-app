import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:should_have_bought_app/screens/buy_or_not/select_drip.dart';
import 'package:should_have_bought_app/widgets/appbar/default_appbar.dart';

class BuyOrNotScreen extends StatefulWidget {
  @override
  _BuyOrNotScreenState createState() => _BuyOrNotScreenState();
}

class _BuyOrNotScreenState extends State<BuyOrNotScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: DefaultAppBar(context),
      body: SelectDripScreen(),
    );
  }
}
