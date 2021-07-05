import 'dart:math';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:flutter/material.dart';
import 'package:should_have_bought_app/models/calculator/calculator_dto.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';
import 'package:should_have_bought_app/utils.dart';
import 'package:should_have_bought_app/widgets/calculator/result/loading_random_widget.dart';
import 'package:should_have_bought_app/widgets/calculator/result/random_widget.dart';

class CalculatorResultAppbar extends StatefulWidget {
  final Color textColor;

  const CalculatorResultAppbar({this.textColor});

  @override
  _CalculatorResultAppbarState createState() => _CalculatorResultAppbarState();
}

class _CalculatorResultAppbarState extends State<CalculatorResultAppbar> {
  bool isLoading = false;

  dynamic randomValues() {
    setState(() {
      isLoading = true;
    });
    final companyList =
        Provider.of<CalculatorProvider>(context, listen: false).companyList;
    final _randomDate = Random().nextInt(dates.length);
    final _randomCompnay = Random().nextInt(companyList.length);
    final _randomPrice = Random().nextInt(prices.length);
    Provider.of<CalculatorProvider>(context, listen: false)
        .randomResult(CalculatorDto(
      code: companyList[_randomCompnay].code,
      investDate: dates[_randomDate],
      investPrice: intToCurrency(prices[_randomPrice]),
    ).toMap())
        .then((_) {
      // setDynamicOption();
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios, color: widget.textColor),
            onPressed: () => Navigator.of(context).pop('update'),
          ),
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Color(0x80FFFFFF),
            ),
            child: isLoading
                ? LoadingRandomWidget(
                    color: widget.textColor,
                  )
                : RandomWidget(
                    onTap: randomValues(),
                    color: widget.textColor,
                  ),
          ),
        ],
      ),
    );
  }
}
