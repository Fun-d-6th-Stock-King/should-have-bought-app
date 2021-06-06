import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';
import 'history_card.dart';

class HeyYouToo extends StatefulWidget {
  @override
  _HeyYouTooState createState() => _HeyYouTooState();
}

class _HeyYouTooState extends State<HeyYouToo> {
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() async {
    await Provider.of<CalculatorProvider>(context, listen: false).getHistory();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
        builder: (context, calculatorProvider, child) {
      final _historyList = calculatorProvider.calculateHistory;
      return _historyList.isEmpty
          ? Container(
              height: 220.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ))
          : Container(
          height: 213,
          // this generates our tabs buttons
          child: Padding(
            padding: const EdgeInsets.only(left:23.0),
            child: ListView.builder(
              // this gives the TabBar a bounce effect when scrolling farther than it's size
                physics: BouncingScrollPhysics(),
                controller: _scrollController,
                // make the list horizontal
                scrollDirection: Axis.horizontal,
                // number of tabs
                itemCount: _historyList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(right:16.0),
                    child: HistoryCard(_historyList[index]),
                  );
                }
            ),
          ));
    });
  }
}
