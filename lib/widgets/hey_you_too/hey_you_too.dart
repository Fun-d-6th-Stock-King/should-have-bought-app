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
    initAdmob();
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

  void initAdmob() {
    interstitialAd = AdmobInterstitial(
      adUnitId: getInterstitialAdUnitId(),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEvent(event, args, 'Interstitial');
      },
    );
    interstitialAd.load();
  }

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        print('New Admob $adType Ad loaded!');
        break;
      case AdmobAdEvent.opened:
        print('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
        {
          sendResultScreen();
          break;
        }
      case AdmobAdEvent.failedToLoad:
        print('Admob $adType failed to load. :(');
        break;
      default:
    }
  }
  void sendResultScreen() async {
    CalculatorDto calculatorDto = await Provider.of<CalculatorWidgetProvider>(context, listen: false).sendCalcuatorDto;
    await Provider.of<CalculatorProvider>(context, listen: false)
        .getResult(calculatorDto.toMap())
        .then((value) {
      EasyLoading.dismiss();
      Navigator.of(context)
          .pushNamed(CalculatorResultScreen.routeId)
          .then((value) => {
        if (value == 'update')
          {
            Provider.of<CalculatorProvider>(context, listen: false)
                .getHistory()
          }
      });
    });
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
