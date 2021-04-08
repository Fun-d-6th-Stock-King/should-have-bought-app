import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/providers/provider_list.dart';
import 'package:should_have_bought_app/routes.dart';
import 'package:should_have_bought_app/screens.dart' show TabScreen;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: kProviders,
      child: MaterialApp(
        title: 'Should Have Bought',
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.black,
          canvasColor: Colors.transparent,
        ),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor:Color(0xFFF5F5F5),
            leading: null,
            elevation: 0,
            actions: <Widget>[
              IconButton(
                  icon: Image(image: AssetImage('assets/icons/search.png')),
                  onPressed: null
              ),
            ],
          ),
          body: Center(
            child: TabScreen(),
          ),
        ),
        // initialRoute: '/',
        // routes: kRoutes,
      ),
    );
  }
}
