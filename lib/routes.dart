import 'package:flutter/cupertino.dart';
import 'package:should_have_bought_app/screens/my_page/guide_page.dart';
import 'screens.dart' show CalculatorResultScreen, TabScreen, OnBoardingScreen;

Map<String, Widget Function(BuildContext)> kRoutes = {
  //Example
  '/': (ctx) => TabScreen(),
  OnBoardingScreen.routeId: (ctx) => OnBoardingScreen(),
  CalculatorResultScreen.routeId: (ctx) => CalculatorResultScreen(),
  // CartScreen.routeId: (ctx) => CartScreen(),
  // OrdersScreen.routeId: (ctx) => OrdersScreen(),
  // UserProductsScreen.routeId: (ctx) => UserProductsScreen(),
  // EditProductScreen.routeId: (ctx) => EditProductScreen(),
  // DripRoomTabScreen.routeId: (ctx) => DripRoomTabScreen(),
  GuidePage.routeId: (ctx) => GuidePage()
};
