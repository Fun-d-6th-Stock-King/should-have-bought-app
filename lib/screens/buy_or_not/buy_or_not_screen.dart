import 'package:flutter/material.dart';
import 'package:should_have_bought_app/widgets/appbar/default_appbar.dart';

class BuyOrNotScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: DefaultAppBar(context),
      body: Container(
        child: Text('BuyOrNotScreen'),
      ),
    );
  }
}