import 'package:flutter/cupertino.dart';
import 'package:should_have_bought_app/screens/buy_or_not/select_drip.dart';
import 'screens.dart' show CalculatorResultScreen;

Map<String, Widget Function(BuildContext)> kRoutes = {
  //Example
  // '/': (ctx) => ProdulctsOverviewScreen(),
  CalculatorResultScreen.routeId: (ctx) => CalculatorResultScreen(),
  // CartScreen.routeId: (ctx) => CartScreen(),
  // OrdersScreen.routeId: (ctx) => OrdersScreen(),
  // UserProductsScreen.routeId: (ctx) => UserProductsScreen(),
  // EditProductScreen.routeId: (ctx) => EditProductScreen(),
  SelectDripScreen.routeId: (ctx) => SelectDripScreen(),
};
