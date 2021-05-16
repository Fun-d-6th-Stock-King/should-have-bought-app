import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/widgets/chart/chart_wiget.dart';
import 'package:should_have_bought_app/widgets/chart/current_stock_chart_widget.dart';
import 'package:should_have_bought_app/widgets/main/current_stock_content_widget.dart';

class CurrentStockPriceWidget extends StatefulWidget {
  @override
  _CurrentStockPriceWidgetState createState() =>
      _CurrentStockPriceWidgetState();
}

class _CurrentStockPriceWidgetState extends State<CurrentStockPriceWidget> {
  int _currentContent = 0;
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
              CarouselSlider(
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
                items: [1, 2, 3, 4].map((i) {
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
                              child: CurrentStockContentWidget()));
                    },
                  );
                }).toList(),
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