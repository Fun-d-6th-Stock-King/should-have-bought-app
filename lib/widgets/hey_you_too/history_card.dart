import 'package:flutter/material.dart';
import 'package:should_have_bought_app/models/calculator/calculator_history.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';
import 'package:should_have_bought_app/screens/stock/stock_detail_screen.dart';
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
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => StockDetailScreen(
              Company(company: history.company,code: history.code),0)
          ));
        },
        child: Container(
          padding: EdgeInsets.only(left: 22, top: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 30,
                      maxWidth: 130,
                      minHeight: 50,
                    ),
                    child: AutoSizeText(
                      '${history.company} ',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      maxFontSize: 22,
                      maxLines: 2,
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 40,
                    ),
                    child: AutoSizeText(
                      convertMinuteToHours(history.createdDate),
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w300),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
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
                  ],
                ),
                maxLines: 1,
              ),
              SizedBox(height: 10),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Container(
                  padding: EdgeInsets.only(
                    left: 5,
                    right: 5,
                  ),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
