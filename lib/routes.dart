import 'package:flutter/cupertino.dart';
import 'file:///D:/git/workspace/fun_d_6/should-have-bought-app/lib/screens/drip_room/drip_room_tab_screen.dart';
import 'screens.dart' show CalculatorResultScreen;

Map<String, Widget Function(BuildContext)> kRoutes = {
  //Example
  // '/': (ctx) => ProdulctsOverviewScreen(),
  CalculatorResultScreen.routeId: (ctx) => CalculatorResultScreen(),
  // CartScreen.routeId: (ctx) => CartScreen(),
  // OrdersScreen.routeId: (ctx) => OrdersScreen(),
  // UserProductsScreen.routeId: (ctx) => UserProductsScreen(),
  // EditProductScreen.routeId: (ctx) => EditProductScreen(),
  DripRoomTabScreen.routeId: (ctx) => DripRoomTabScreen(),
};
