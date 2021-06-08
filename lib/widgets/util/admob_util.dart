import 'package:shared_preferences/shared_preferences.dart';

// interstitialAd.show();
Future<bool> getAdMobCounter() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int counter = (prefs.getInt('counter') ?? 0) + 1;
  print('Pressed $counter ');
  await prefs.setInt('counter', counter);
  if(counter%4 == 0) {
    return true;
  }
  return false;
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
  return 'ca-app-pub-3526133822093148/1512973558';
}