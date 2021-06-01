import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';
import 'package:should_have_bought_app/widgets/main/current_stock_content_widget.dart';
import 'package:should_have_bought_app/models/calculator/current_stock_price.dart';

class CurrentStockPriceWidget extends StatefulWidget {
  @override
  _CurrentStockPriceWidgetState createState() =>
      _CurrentStockPriceWidgetState();
}

class _CurrentStockPriceWidgetState extends State<CurrentStockPriceWidget> {
  int _currentContent = 0;

  @override
  void didChangeDependencies() async{
    await Provider.of<CalculatorProvider>(context, listen:false).getCurrentStockPrice();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 23,
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey[200],
                offset: Offset(0, 0), //(x,y)
                blurRadius: 25.0,
                spreadRadius: 0.0,
              ),
            ],
          ),
          child: Column(
            children: [
              Consumer<CalculatorProvider>(
                builder: (context, calculatorProvider, child) {
                  List<CurrentStockPrice> currentStockPriceList = calculatorProvider.currentStockPriceList;
                  return CarouselSlider(
                    options: CarouselOptions(
                      height: 350,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 5),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentContent = index;
                        });
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                    items: currentStockPriceList.map((CurrentStockPrice currentStockPrice) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 7.5),
                              child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: CurrentStockContentWidget(currentStockPrice)));
                        },
                      );
                    }).toList(),
                  );
                }
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [1, 2, 3, 4].map((url) {
            int index = [1, 2, 3, 4].indexOf(url);
            return Container(
              width: _currentContent == index ? 32 : 10,
              height: 10,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
              decoration: BoxDecoration(
                borderRadius: _currentContent == index
                    ? BorderRadius.circular(20.0)
                    : BorderRadius.circular(100.0),
                color: _currentContent == index ? mainColor : Color(0xFFDFDFDF),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}