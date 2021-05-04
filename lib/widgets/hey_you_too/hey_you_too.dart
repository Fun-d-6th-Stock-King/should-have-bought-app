import 'package:carousel_slider/carousel_slider.dart';
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
  List _historyList;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<CalculatorProvider>(context).getHistory(1, 10);
    _historyList = Provider.of<CalculatorProvider>(context).calculateHistory;
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 220.0,
        viewportFraction: 0.7,
        enableInfiniteScroll: false,
      ),
      items: _historyList.map((history) {
        return Builder(
          builder: (context) {
            return HistoryCard(history);
          },
        );
      }).toList(),
    );
  }
}
