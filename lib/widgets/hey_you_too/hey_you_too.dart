import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/models/calculator/calculator_dto.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_widget_provider.dart';
import 'package:should_have_bought_app/screens/main/calculator_result_screen.dart';
import 'package:should_have_bought_app/widgets/util/admob_util.dart';
import 'history_card.dart';
import 'package:should_have_bought_app/providers/admob/admob_provider.dart';

class HeyYouToo extends StatefulWidget {
  @override
  _HeyYouTooState createState() => _HeyYouTooState();
}

class _HeyYouTooState extends State<HeyYouToo> {
  final ScrollController _scrollController = ScrollController();
  AdmobInterstitial interstitialAd;

  @override
  void initState() {
    super.initState();
    interstitialAd = Provider.of<AdmobProvider>(context, listen:false).interstitialAd;
  }

  @override
  void didChangeDependencies() async {
    await Provider.of<CalculatorProvider>(context, listen: false).getHistory();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    interstitialAd.dispose();
    super.dispose();
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
                    child: HistoryCard(_historyList[index], interstitialAd),
                  );
                }
            ),
          ));
    });
  }
}
