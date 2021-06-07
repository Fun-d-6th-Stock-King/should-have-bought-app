import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/models/calculator/high_price_ten_year.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';
import 'package:should_have_bought_app/utils.dart';

class AnyPastYearWidget extends StatefulWidget {
  final String day;
  final String money;

  AnyPastYearWidget({this.day, this.money});

  @override
  _AnyPastYearWidgetState createState() => _AnyPastYearWidgetState();
}

class _AnyPastYearWidgetState extends State<AnyPastYearWidget> {
  final topStocks = [
    '삼성전자',
    'SK하이닉스',
    '카카오',
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, calculatorProvider, child) {
        final calculatorResult = calculatorProvider.calculationResult;
        return calculatorResult.yieldPercent > 0
            ? Container()
            : Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${calculatorResult.investDate} ${convertMoney(calculatorResult.investPrice)}원 이면...😭',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  calculatorResult == null
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          height: 25,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            separatorBuilder: (context, index) {
                              return SizedBox(width: 10);
                            },
                            itemBuilder: (context, index) {
                              return FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    // color: Colors.black,
                                    color: Color(0xFF939393).withOpacity(0.09),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25.0),
                                    ),
                                  ),
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: StockTile(
                                      company: topStocks[index],
                                      stocks: calculatorResult
                                          .topStocks[topStocks[index]],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                ],
              );
      },
    );
  }
}

class StockTile extends StatelessWidget {
  final String company;
  final double stocks;

  const StockTile({this.company, this.stocks});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          company,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          height: 20,
          child: VerticalDivider(
            width: 10,
          ),
        ),
        Text(
          '${stocks.toStringAsFixed(1)}주',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
