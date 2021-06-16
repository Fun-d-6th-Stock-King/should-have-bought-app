import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/models/calculator/calculator_dto.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_widget_provider.dart';
import 'package:should_have_bought_app/screens/main/calculator_result_screen.dart';
import 'package:should_have_bought_app/widgets/util/admob_util.dart';

class AdmobProvider with ChangeNotifier {
  String test;
  AdmobInterstitial _interstitialAd;

  AdmobInterstitial get interstitialAd => _interstitialAd;

  void initAdmob(BuildContext context) {
    print('init Admob');
    _interstitialAd = AdmobInterstitial(
      adUnitId: getInterstitialAdUnitId(),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) {
          print('admob closed and reload');
          _interstitialAd.load();
        }
        handleEvent(event, args, 'Interstitial', context);
      },
    );
    _interstitialAd.load();
  }

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType, BuildContext context) {
    switch (event) {
      case AdmobAdEvent.loaded:
        print('New Admob $adType Ad loaded!');
        break;
      case AdmobAdEvent.opened:
        print('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
        {
          moveResultScreen(context);
          break;
        }
      case AdmobAdEvent.failedToLoad:
        print('Admob $adType failed to load. :(');
        break;
      default:
    }
  }
  void moveResultScreen(BuildContext context) async {
    Company selectedCompany =
        Provider.of<CalculatorWidgetProvider>(context, listen: false)
            .selectedCompany;
    String selectedDateValue =
        Provider.of<CalculatorWidgetProvider>(context, listen: false)
            .selectedDateValue;
    String price =  Provider.of<CalculatorWidgetProvider>(context, listen: false).price;
    await Provider.of<CalculatorProvider>(context, listen: false)
        .getResult(CalculatorDto(
        code: selectedCompany.code,
        investDate: selectedDateValue,
        investPrice: int.parse(price))
        .toMap())
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
}