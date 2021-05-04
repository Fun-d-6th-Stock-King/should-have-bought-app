import 'package:flutter/material.dart';
import 'package:should_have_bought_app/models/calculator/calculator_history.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:should_have_bought_app/utils.dart';

class HistoryCard extends StatelessWidget {
  final CalculatorHistory history;
  DateTime now = DateTime.now();

  HistoryCard(this.history);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
        color: Color(0xffF5F5F5),
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 22, top: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  history.company,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                SizedBox(width: 5),
                Text(
                  '1분 전',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w300),
                ),
              ],
            ),
            SizedBox(height: 63),
            Text(
              '${history.investDateName}보다',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            AutoSizeText.rich(
              TextSpan(
                  style: TextStyle(
                    color: (history.yieldPercent > 0)
                        ? Colors.red
                        : (history.yieldPercent < 0)
                            ? Colors.blue
                            : Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 21,
                  ),
                  children: <TextSpan>[
                    (history.yieldPercent > 0)
                        ? TextSpan(text: '+')
                        : (history.yieldPercent < 0)
                            ? TextSpan(text: '-')
                            : TextSpan(),
                    TextSpan(text: '${numberWithComma(history.yieldPrice)}원'),
                    TextSpan(
                      text: '(${history.yieldPercent}%)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ]),
            ),
            SizedBox(height: 10),
            Container(
              width: 125,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '현재가',
                    style: TextStyle(
                      color: Color(0xff6D6D6D),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    height: 10,
                    child: VerticalDivider(
                      width: 10,
                    ),
                  ),
                  Text(
                    '${numberWithComma(history.price)}원/1주',
                    style: TextStyle(
                      color: Color(0xff6D6D6D),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
