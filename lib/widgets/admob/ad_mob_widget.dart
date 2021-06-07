import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';

class AdMobWidget extends StatefulWidget {
  @override
  _CreateAdMobWidgetState createState() => _CreateAdMobWidgetState();
}

class _CreateAdMobWidgetState extends State<AdMobWidget> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  AdmobInterstitial interstitialAd;
  AdmobReward rewardAd;

  @override
  void initState() {
    super.initState();
    interstitialAd = AdmobInterstitial(
      adUnitId: getInterstitialAdUnitId(),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEvent(event, args, 'Interstitial');
      },
    );
    rewardAd = AdmobReward(
      adUnitId: getRewardBasedVideoAdUnitId(),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) rewardAd.load();
        handleEvent(event, args, 'Reward');
      },
    );
    interstitialAd.load();
    rewardAd.load();
  }

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        showSnackBar('New Admob $adType Ad loaded!');
        break;
      case AdmobAdEvent.opened:
        showSnackBar('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
        showSnackBar('Admob $adType Ad closed!');
        break;
      case AdmobAdEvent.failedToLoad:
        showSnackBar('Admob $adType failed to load. :(');
        break;
      case AdmobAdEvent.rewarded:
        showDialog(
          context: scaffoldState.currentContext,
          builder: (BuildContext context) {
            return WillPopScope(
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Reward callback fired. Thanks Andrew!'),
                    Text('Type: ${args['type']}'),
                    Text('Amount: ${args['amount']}'),
                  ],
                ),
              ),
              onWillPop: () async {
                scaffoldState.currentState.hideCurrentSnackBar();
                return true;
              },
            );
          },
        );
        break;
      default:
    }
  }

  void showSnackBar(String content) {
    scaffoldState.currentState.showSnackBar(
      SnackBar(
        content: Text(content),
        duration: Duration(milliseconds: 1500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: FlatButton(
            child: Text(
              'Show Interstitial',
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () async {
              if (await interstitialAd.isLoaded) {
                interstitialAd.show();
              } else {
                showSnackBar(
                    'Interstitial ad is still loading...');
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
        ),
        Expanded(
          child: FlatButton(
            child: Text(
              'Show Reward',
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () async {
              if (await rewardAd.isLoaded) {
                rewardAd.show();
              } else {
                showSnackBar('Reward ad is still loading...');
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    interstitialAd.dispose();
    rewardAd.dispose();
    super.dispose();
  }
}

/*
Test Id's from:
https://developers.google.com/admob/ios/banner
https://developers.google.com/admob/android/banner

App Id - See README where these Id's go
Android: ca-app-pub-3940256099942544~3347511713
iOS: ca-app-pub-3940256099942544~1458002511

Banner
Android: ca-app-pub-3940256099942544/6300978111
iOS: ca-app-pub-3940256099942544/2934735716

Interstitial
Android: ca-app-pub-3940256099942544/1033173712
iOS: ca-app-pub-3940256099942544/4411468910

Reward Video
Android: ca-app-pub-3940256099942544/5224354917
iOS: ca-app-pub-3940256099942544/1712485313

Interstitial Reward
ca-app-pub-3940256099942544/5354046379
*/


String getInterstitialAdUnitId() {
  // if (Platform.isIOS) {
  //   return 'ca-app-pub-3940256099942544/4411468910';
  // } else if (Platform.isAndroid) {
  //   return 'ca-app-pub-3940256099942544/1033173712';
  // }
  // ca-app-pub-3526133822093148/1512973558
  return 'ca-app-pub-3940256099942544/1033173712';
}

String getRewardBasedVideoAdUnitId() {
  // if (Platform.isIOS) {
  //   return 'ca-app-pub-3940256099942544/1712485313';
  // } else if (Platform.isAndroid) {
  //   return 'ca-app-pub-3940256099942544/5224354917';
  // }
  //return 'ca-app-pub-3526133822093148/4982822964';
  return 'ca-app-pub-3940256099942544/5224354917';
}