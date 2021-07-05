import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/calculator/calculator_stock.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';
import 'package:should_have_bought_app/utils.dart';
import 'package:should_have_bought_app/widgets/calculator/result/loading_random_widget.dart';
import 'package:should_have_bought_app/widgets/calculator/result/random_widget.dart';
import 'package:should_have_bought_app/widgets/calculator/result/result_card_widget.dart';

class CalculatorResultWidget extends StatefulWidget {
  final Color topColor;
  final Color textColor;
  final AssetImage chickImage;
  final bool isLoading;
  final Function onTap;

  const CalculatorResultWidget(
      {this.topColor,
      this.textColor,
      this.chickImage,
      this.isLoading = false,
      this.onTap});

  @override
  _CalculatorResultWidgetState createState() => _CalculatorResultWidgetState();
}

class _CalculatorResultWidgetState extends State<CalculatorResultWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
        builder: (context, calculatorProvider, child) {
      final calculationResult = calculatorProvider.calculationResult;
      return Stack(
        children: <Widget>[
          CustomPaint(
            painter: MyPainter(widget.topColor),
            size: Size(516, 316),
          ),
          Container(
            padding: EdgeInsets.only(top: 190),
            alignment: Alignment.center,
            child: Image(
              image: widget.chickImage,
            ),
          ),
          Column(
            children: [
              SizedBox(height: 10),
              CalculatorResultAppbar(
                textColor: widget.textColor,
                isLoading: widget.isLoading,
                onTap: widget.onTap,
              ),
              SizedBox(height: 2),
              Container(
                height: 175,
                child: Column(
                  children: [
                    MainTopText(
                      textColor: widget.textColor,
                      investDate: calculationResult.investDate,
                    ),
                    MainMidText(
                      textColor: widget.textColor,
                      companyName: calculationResult.name,
                    ),
                    MainBottomText(
                      textColor: widget.textColor,
                      investPrice: calculationResult.investPrice,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ResultCardWidget(calculationResult: calculationResult)
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
    });
  }
}

class CalculatorResultAppbar extends StatelessWidget {
  final Color textColor;
  final bool isLoading;
  final Function onTap;

  const CalculatorResultAppbar({
    this.textColor,
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios, color: textColor),
            onPressed: () => Navigator.of(context).pop('update'),
          ),
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Color(0x80FFFFFF),
            ),
            child: isLoading
                ? LoadingRandomWidget(
                    color: textColor,
                  )
                : RandomWidget(
                    onTap: onTap,
                    color: textColor,
                  ),
          ),
        ],
      ),
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
