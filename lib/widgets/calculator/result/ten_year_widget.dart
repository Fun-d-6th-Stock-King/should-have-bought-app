import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';

class TenYearWidget extends StatefulWidget {
  final String day;
  final String money;

  TenYearWidget({this.day, this.money});

  @override
  _TenYearWidgetState createState() => _TenYearWidgetState();
}

class _TenYearWidgetState extends State<TenYearWidget> {
  List _tenYearList;

  @override
  void didChangeDependencies() {
    Provider.of<CalculatorProvider>(context, listen: false)
        .getTenYearHigher()
        .then((value) => {
              _tenYearList =
                  Provider.of<CalculatorProvider>(context, listen: false)
                      .tenYearHighList,
            });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            '${widget.day}? ${widget.money}원 이면...😭',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        _tenYearList == null
            ? CircularProgressIndicator()
            : Container(
                padding: EdgeInsets.only(left: 20),
                height: 25,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _tenYearList.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 25);
                    },
                    itemBuilder: (context, index) {
                      return FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Container(
                          height: 35,
                          decoration: BoxDecoration(
                            // color: Colors.black,
                            color: Color(0x17939393),
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Text(
                                  _tenYearList[index]["company"],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
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
                                  _tenYearList[index]["high"].toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
      ],
    );
  }
}
