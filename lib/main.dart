import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/providers/provider_list.dart';
import 'package:should_have_bought_app/routes.dart';
import 'package:should_have_bought_app/screens.dart' show TabScreen;
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

Future main() async {
  await DotEnv.load(fileName: ".env");
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
          primaryColor: Color.fromARGB(255, 229, 229, 229),
          accentColor: Colors.black,
        ),
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child,
          );
        },
        routes: kRoutes,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: defaultBackgroundColor,
            leading: null,
            elevation: 0,
            actions: <Widget>[
              IconButton(
<<<<<<< HEAD
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
=======
                  icon: Image(image: AssetImage('assets/icons/search.png')),
>>>>>>> origin/develop
                  onPressed: null),
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

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
