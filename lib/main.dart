import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kakao_flutter_sdk/common.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/providers/provider_list.dart';
import 'package:should_have_bought_app/routes.dart';
import 'package:should_have_bought_app/screens.dart' show TabScreen;
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

Future main() async {
  // TODO : .env.prod 사용시 file not found 에러, 확인 필요
  await DotEnv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Admob.initialize();
  // Or add a list of test ids.
  // 352675100585341
  // Admob.initialize(testDeviceIds: ['YOUR DEVICE ID']);
  KakaoContext.clientId = env['KAKAO_CLIENT_ID'];
  KakaoContext.javascriptClientId = env['KAKAO_JAVASCRIPT_CLIENT_ID'];
  // 디버그시에 필요
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  // ));
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: kProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Should Have Bought',
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 229, 229, 229),
          accentColor: Colors.black,
        ),
        builder: EasyLoading.init(),
        //     (context, child) {
        //   return ScrollConfiguration(
        //     behavior: MyBehavior(),
        //     child: child,
        //   );
        // },
        routes: kRoutes,
        home: Scaffold(
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
