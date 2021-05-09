import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/widgets/chart/chart_wiget.dart';
import 'package:should_have_bought_app/widgets/chart/current_stock_chart_widget.dart';

class CurrentStockPriceWidget extends StatefulWidget {
  @override
  _CurrentStockPriceWidgetState createState() =>
      _CurrentStockPriceWidgetState();
}

class _CurrentStockPriceWidgetState extends State<CurrentStockPriceWidget> {
  int _current = 0;

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
                      _current = index;
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
                              child: currentStockPriceContent(context, i)));
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
              width: _current == index ? 32 : 10,
              height: 10,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
              decoration: BoxDecoration(
                borderRadius: _current == index
                    ? BorderRadius.circular(20.0)
                    : BorderRadius.circular(100.0),
                color: _current == index ? mainColor : Color(0xFFDFDFDF),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}

Widget currentStockPriceContent(BuildContext context, int i) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(left: 18, top: 31, right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '한국타이어앤테크놀로지',
            style: TextStyle(
                fontSize: 18, height: 26 / 18, fontWeight: FontWeight.w500),
          ),
          Text(
            '87,100원',
            style: TextStyle(
                fontSize: 34,
                height: 49 / 34,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4F8AEF)),
          ),
          Text(
            '-0.44%',
            style: TextStyle(
                fontSize: 23,
                height: 27 / 23,
                fontWeight: FontWeight.w300,
                color: Color(0xFF4F8AEF)),
          ),
          SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              currentStockPriceContentButton('전체', true),
              currentStockPriceContentButton('장중', false),
              currentStockPriceContentButton('주간', false),
              currentStockPriceContentButton('연간', false)
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
              color: Color.fromRGBO(245, 245, 245, 0.98)
            ),
            child: CurrentStockChartWidget(),
          )
        ],
      ),
    ),
  );
}

Widget currentStockPriceContentButton(String name, bool current) {
  return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 2.0),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color: current ? mainColor: Colors.transparent,
                width: 2.5,
              ))),
      child: Text(
        name,
        style: TextStyle(
            fontSize: 15,
            color: current ? Color(0XFF000000) : Color(0xFF979797),
            fontWeight: FontWeight.w500,
            height: 22 / 15),
      )
  );
}