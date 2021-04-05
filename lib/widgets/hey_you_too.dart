import 'package:flutter/material.dart';

class HeyYouToo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 374,
      height: 514,
      decoration: BoxDecoration(
        border: Border.all(width: 3.0),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 27,
              left: 18,
            ),
            child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                    '그때 살걸... 야, 너두?',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 356,
            height: 412,
            decoration: BoxDecoration(
              border: Border.all(width: 3.0),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            margin: EdgeInsets.only(
              top: 18,
              left: 10,
              right: 10,
            ),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(),
                  width: 338,
                  height: 138,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
