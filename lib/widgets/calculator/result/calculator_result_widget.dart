import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/calculator/calculator_stock.dart';
import 'package:should_have_bought_app/utils.dart';
import 'package:should_have_bought_app/widgets/calculator/result/result_card_widget.dart';
import 'package:should_have_bought_app/widgets/appbar/calculator_result_appbar.dart';

class CalculatorResultWidget extends StatefulWidget {
  final Color topColor;
  final Color textColor;
  final AssetImage chickImage;
  final CalculatorStock calculationResult;

  const CalculatorResultWidget({
    this.topColor,
    this.textColor,
    this.chickImage,
    this.calculationResult,
  });

  @override
  _CalculatorResultWidgetState createState() => _CalculatorResultWidgetState();
}

class _CalculatorResultWidgetState extends State<CalculatorResultWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomPaint(
          painter: MyPainter(widget.topColor),
          size: Size(516, 316),
        ),
        Container(
          padding: EdgeInsets.only(top: 130),
          alignment: Alignment.center,
          child: Image(
            image: widget.chickImage,
          ),
        ),
        Column(
          children: [
            SizedBox(height: 10),
            // CalculatorResultAppbar(
            //   textColor: widget.textColor,
            // ),
            SizedBox(height: 2),
            Container(
              height: 175,
              child: Column(
                children: [
                  MainTopText(
                    textColor: widget.textColor,
                    investDate: widget.calculationResult.investDate,
                  ),
                  MainMidText(
                    textColor: widget.textColor,
                    companyName: widget.calculationResult.name,
                  ),
                  MainBottomText(
                    textColor: widget.textColor,
                    investPrice: widget.calculationResult.investPrice,
                  ),
                ],
              ),
            ),
            ResultCardWidget(calculationResult: widget.calculationResult)
          ],
        ),
        // isBottomSheet == true
        //     ? GestureDetector(
        //         onTap: () {
        //           setState(() => isBottomSheet = false);
        //         },
        //         child: CustomPaint(
        //           painter: MyPainter(Colors.black.withOpacity(0.5)),
        //           size: Size(MediaQuery.of(context).size.width,
        //               MediaQuery.of(context).size.height),
        //         ),
        //       )
        //     : Container(),
      ],
    );
  }
}

class MainBottomText extends StatelessWidget {
  final Color textColor;
  final String investPrice;

  MainBottomText({this.textColor, this.investPrice});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText.rich(
      TextSpan(
        style: TextStyle(
          fontSize: 24,
          color: textColor,
          fontWeight: FontWeight.w300,
        ),
        children: <TextSpan>[
          TextSpan(
            text: numberWithComma(investPrice),
            style: kMainBoldTextStyle,
          ),
          TextSpan(
            text: '원 샀으면 지금..?',
          ),
        ],
      ),
      maxLines: 1,
      minFontSize: 10,
    );
  }
}

class MainTopText extends StatelessWidget {
  final Color textColor;
  final String investDate;
  MainTopText({this.textColor, this.investDate});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText.rich(
      TextSpan(
        style: TextStyle(
          fontSize: 24,
          color: textColor,
          fontWeight: FontWeight.w300,
        ),
        children: <TextSpan>[
          TextSpan(
            text: investDate,
            style: kMainBoldTextStyle,
          ),
          TextSpan(
            text: '에 ',
          ),
        ],
      ),
      maxLines: 1,
      minFontSize: 10,
    );
  }
}

class MainMidText extends StatelessWidget {
  final Color textColor;
  final String companyName;

  MainMidText({this.textColor, this.companyName});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText.rich(
      TextSpan(
        style: TextStyle(
          fontSize: 24,
          color: textColor,
          fontWeight: FontWeight.w300,
        ),
        children: <TextSpan>[
          TextSpan(
            text: companyName,
            style: kMainBoldTextStyle,
          ),
          TextSpan(
            text: '를',
          )
        ],
      ),
      maxLines: 1,
      minFontSize: 10,
    );
  }
}

class MyPainter extends CustomPainter {
  final Color topColor;

  MyPainter(this.topColor);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = topColor;
    var path = Path();
    canvas.drawCircle(
        Offset(size.width * 0.5, size.height * 0.2), size.height * 1, paint);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
