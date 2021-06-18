import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/buy_or_not/buy_or_not_stock.dart';
import 'package:should_have_bought_app/models/buy_or_not/stock_evaluation_item.dart';
import 'package:should_have_bought_app/providers/buy_or_not/buy_or_not_provider.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';
import 'package:should_have_bought_app/utils.dart';

class BuyOrNotWidget extends StatefulWidget {
  @override
  _BuyOrNotWidgetState createState() => _BuyOrNotWidgetState();
}

class _BuyOrNotWidgetState extends State<BuyOrNotWidget> {
  @override
  void didChangeDependencies() {
    // final _lastDto =
    //     Provider.of<CalculatorProvider>(context, listen: false).latestDto;
    // Provider.of<BuyOrNotProvider>(context, listen: false)
    //     .getBuyOrNotStock(_lastDto['code']);
    // Provider.of<BuyOrNotProvider>(context, listen: false)
    //     .getBestEvaluateList(1, 1, 'MONTH12', _lastDto['code']);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<BuyOrNotProvider, CalculatorProvider>(
        builder: (context, buyOrNotProvider, calculatorProvider, child) {
      StockEvaluationItem _bestStockEvaluateList;
      final _buyStock = buyOrNotProvider.buyOrNotStock;
      final _stockResult = calculatorProvider.calculationResult;
      final _stockEvaluateList =
          buyOrNotProvider.stockEvaluationList.evaluationList;
      if (_stockEvaluateList != null && _stockEvaluateList.isNotEmpty) {
        _bestStockEvaluateList = _stockEvaluateList[0];
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '살까?말까?',
                  style: kResultTitleStyle,
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Text('${_stockResult.name} 살래 말래?'),
          SizedBox(height: 10),
          BuyOrNotBox(buyStock: _buyStock),
          SizedBox(height: 15.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  'BEST 한줄평',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              BestOneLineBox(bestStockEvaluateList: _bestStockEvaluateList),
            ],
          ),
        ],
      );
    });
  }
}

class BestOneLineBox extends StatelessWidget {
  const BestOneLineBox({
    Key key,
    @required StockEvaluationItem bestStockEvaluateList,
  })  : _bestStockEvaluateList = bestStockEvaluateList,
        super(key: key);

  final StockEvaluationItem _bestStockEvaluateList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13.0),
        color: Color(0xFFAEAEAE).withOpacity(0.16),
      ),
      child: _bestStockEvaluateList == null
          ? Center(child: Text('등록된 평가가 없어요!'))
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                                left: 4, top: 1, bottom: 1, right: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: possibleColor,
                            ),
                            child: Text(
                              '장점',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 15),
                          AutoSizeText(
                            _bestStockEvaluateList.cons,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                height: 20 / 14),
                            presetFontSizes: [14, 13],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                                left: 4, top: 1, bottom: 1, right: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: nagativeColor,
                            ),
                            child: Text(
                              '단점',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 15),
                          AutoSizeText(
                            _bestStockEvaluateList.pros,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                height: 20 / 14),
                            presetFontSizes: [14, 13],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class BuyOrNotBox extends StatelessWidget {
  const BuyOrNotBox({
    Key key,
    @required BuyOrNotStock buyStock,
  })  : _buyStock = buyStock,
        super(key: key);

  final BuyOrNotStock _buyStock;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13.0),
        color: Color(0xFFAEAEAE).withOpacity(0.16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconWithNumber(
            icon: AssetImage('assets/icons/ico_like_small.png'),
            text: '살?',
            number: _buyStock.buyCount,
            color: Colors.red,
          ),
          Container(
            height: 34,
            child: VerticalDivider(
              color: Color(0xFFDADADA),
            ),
          ),
          IconWithNumber(
            icon: AssetImage('assets/icons/ico_unlike_small.png'),
            text: '말?',
            number: _buyStock.sellCount,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}

class IconWithNumber extends StatelessWidget {
  final AssetImage icon;
  final String text;
  final int number;
  final Color color;

  const IconWithNumber({this.icon, this.text, this.number, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageIcon(
                icon,
                color: color,
                size: 15.0,
              ),
              SizedBox(width: 2.0),
              Text(
                text,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text(
              numberWithComma(
                number?.toString() ?? '',
              ),
            ),
          )
        ],
      ),
    );
  }
}
