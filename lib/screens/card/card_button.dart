import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';

class CardButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Image icon;

  CardButton({@required this.title, @required this.onPressed, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size(66,66),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: mainColor,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0), //side: BorderSide(color: Colors.red)
            )
        ),
        onPressed: () {
          if(onPressed != null) {
            onPressed();
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon ?? Container(), // icon
            Text(title ?? "", style: TextStyle(
                fontSize: 12,
                height: 18/12,
                color: Colors.black
            ),), // text
          ],
        ),
      ),
    );
  }
}