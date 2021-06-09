import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:should_have_bought_app/providers/buy_or_not/buy_or_not_provider.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_widget_provider.dart';
import 'package:should_have_bought_app/providers/drip_room/drip_room_provider.dart';
import 'package:should_have_bought_app/providers/dummy.dart';
import 'package:should_have_bought_app/providers/today_word/today_word_provider.dart';
import 'package:should_have_bought_app/providers/my_page/my_page_provider.dart';

List<SingleChildWidget> kProviders = [
  // Example
  ChangeNotifierProvider(
    create: (context) => Dummy(),
  ),
  ChangeNotifierProvider<CalculatorProvider>(
      create: (context) => CalculatorProvider()
  ),
  ChangeNotifierProvider<DripRoomProvider>(
      create: (context) => DripRoomProvider()
  ),
  ChangeNotifierProvider<BuyOrNotProvider>(
      create: (context) => BuyOrNotProvider()
  ),
  ChangeNotifierProvider<CalculatorWidgetProvider>(
      create: (context) => CalculatorWidgetProvider()
  ),
  ChangeNotifierProvider<TodayWordProvider>(
      create: (context) => TodayWordProvider()
  ),
  ChangeNotifierProvider<MyPageProvider>(
      create: (context) => MyPageProvider()
  ),
];
