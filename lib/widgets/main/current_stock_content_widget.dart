import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/utils.dart';
import 'package:should_have_bought_app/widgets/chart/current_stock_chart_widget.dart';
import 'package:should_have_bought_app/models/calculator/current_stock_price.dart';

class CurrentStockContentWidget extends StatefulWidget {
  final CurrentStockPrice currentStockPrice;

  CurrentStockContentWidget(this.currentStockPrice);

  @override
  _CurrentStockContentWidgetState createState() =>
      _CurrentStockContentWidgetState();
}

class _CurrentStockContentWidgetState extends State<CurrentStockContentWidget> {
  String _currentButton = '전체';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 18, top: 31, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.currentStockPrice.company,
              style: TextStyle(
                  fontSize: 18, height: 26 / 18, fontWeight: FontWeight.w500),
            ),
            Text(
              '${numberWithComma(widget.currentStockPrice.price.toStringAsFixed(0))}원',
              style: TextStyle(
                  fontSize: 34,
                  height: 49 / 34,
                  fontWeight: FontWeight.w500,
                  color: widget.currentStockPrice.changeInPercent > 0
                      ? possibleColor
                      : nagativeColor),
            ),
            Row(
              children: [
                widget.currentStockPrice.changeInPercent > 0
                    ? Text(
                        '+',
                        style: TextStyle(
                            fontSize: 23,
                            height: 27 / 23,
                            fontWeight: FontWeight.w300,
                            color: possibleColor),
                      )
                    : Text(''),
                Text(
                  '${widget.currentStockPrice.changeInPercent}%',
                  style: TextStyle(
                      fontSize: 23,
                      height: 27 / 23,
                      fontWeight: FontWeight.w300,
                      color: widget.currentStockPrice.changeInPercent > 0
                          ? possibleColor
                          : nagativeColor),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                currentStockPriceContentButton('전체'),
                currentStockPriceContentButton('장중'),
                currentStockPriceContentButton('주간'),
                currentStockPriceContentButton('연간')
              ],
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              height: 128,
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  color: Color.fromRGBO(245, 245, 245, 0.98)),
              child: CurrentStockChartWidget(type: _currentButton, value:widget.currentStockPrice),
            )
          ],
        ),
      ),
    );
  }

  Widget currentStockPriceContentButton(String name) {
    return InkWell(
      onTap: () {
        setState(() {
          _currentButton = name;
        });
      },
      child: Container(
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.symmetric(horizontal: 2.0),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: _currentButton == name ? mainColor : Colors.transparent,
            width: 2.5,
          ))),
          child: Text(
            name,
            style: TextStyle(
                fontSize: 15,
                color: _currentButton == name
                    ? Color(0XFF000000)
                    : Color(0xFF979797),
                fontWeight: FontWeight.w500,
                height: 22 / 15),
          )),
    );
  }
}
