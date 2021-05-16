import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/models/calculator/result/sectorData.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';
import 'package:should_have_bought_app/utils.dart';

class CurrentValueWidget extends StatefulWidget {
  @override
  _CurrentValueWidgetState createState() => _CurrentValueWidgetState();
}

class _CurrentValueWidgetState extends State<CurrentValueWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
        builder: (context, calculatorProvider, child) {
      SectorData sectorData = calculatorProvider.sectorData;
      Map<String, dynamic> lastDto = calculatorProvider.latestDto;
      return sectorData == null
          ? Container(child: CircularProgressIndicator())
          : Container(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '믿고 싶지 않은 현재가',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '${sectorData.currentTime} 기준',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff828282),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18),
                  Container(
                    height: 86,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffC2C2C2).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFF1F1F1),
                            offset: Offset(2.0, 13.0),
                            blurRadius: 35.0,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '1주당 가격',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff828282),
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: AutoSizeText(
                                  '${numberWithComma(
                                    sectorData.currentPricePerStock.toString(),
                                  )} 원',
                                  maxLines: 1,
                                  minFontSize: 22,
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: 57,
                            child: VerticalDivider(
                              color: Color(0xff979797),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${convertMoney(lastDto['investPrice'])}원 매수시',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff828282),
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: AutoSizeText(
                                  '${sectorData.currentStockPerPrice.toStringAsFixed(2)}주',
                                  minFontSize: 22,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
