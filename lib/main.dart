import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/providers/provider_list.dart';
import 'package:should_have_bought_app/routes.dart';

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
          // 임시 색상
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(0.0),
            ),
          ),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Should Have Bought'),
          ),
          body: Center(
            child: Text('Hi'),
          ),
        ),
        // initialRoute: '/',
        // routes: kRoutes,
      ),
    );
  }
}
