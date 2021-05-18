import 'package:flutter/material.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';
import 'package:should_have_bought_app/widgets/buy_or_not/buy_or_not_select_widget.dart';
import 'package:should_have_bought_app/widgets/buy_or_not/how_to_bought_then_widget.dart';

class BuyorNotTabScreen extends StatelessWidget {
  final Company company;

  BuyorNotTabScreen(this.company);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            BuyorNotSelectWidget(company.code),
            SizedBox(height: 20),
            HowToBoughtThenWidget(company),
          ],
        ),
      ),
    );
  }
}