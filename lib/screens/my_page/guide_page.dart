import 'package:flutter/material.dart';

class GuidePage extends StatelessWidget {
  static const routeId = '/guide-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constrains) {
        return Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              // height: constrains.biggest.height,
              child: Image(
                image: AssetImage('assets/images/guide.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        );
      }),
    );
  }
}
