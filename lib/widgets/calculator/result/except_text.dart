import 'package:flutter/material.dart';
import 'package:should_have_bought_app/models/calculator/calculator_stock.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/utils.dart';

class DateExceptText extends StatelessWidget {
  final CalculatorStock calculatorResult;
  const DateExceptText(this.calculatorResult);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 19,
        ),
        children: [
          TextSpan(
            text: '${dateValue[calculatorResult.exceptionCase.oldInvestDate]}',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: '에는 상장 전인 종목이예요. \n 대신 ',
          ),
          TextSpan(
            text: '${dateValue[calculatorResult.exceptionCase.newInvestDate]}',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: '정보를 알려드릴게요.',
          )
        ],
      ),
    );
  }
}

class PriceExceptText extends StatelessWidget {
  final CalculatorStock calculatorResult;
  const PriceExceptText(this.calculatorResult);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 19,
        ),
        children: [
          TextSpan(
            text:
                '${dateValue[calculatorResult.exceptionCase.oldInvestDate]} ${convertMoney(calculatorResult.exceptionCase.oldInvestPrice.toString())}원',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: '으로는 1주도 살 수 없어요.\n',
          ),
          TextSpan(
            text: '1주 금액 기준',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: '으로 알려드릴게요.',
          )
        ],
      ),
    );
  }
}

class HaltExceptText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: kExceptStyle,
        children: [
          TextSpan(text: '잠깐! '),
          TextSpan(
            text: '거래중지',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(text: '된 종목이에요\n'),
          TextSpan(text: '거래중지 사유를 확인 후 신중하게 거래하세요.')
        ],
      ),
    );
  }
}

class AlertExceptText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: kExceptStyle,
        children: [
          TextSpan(text: '잠깐! '),
          TextSpan(
            text: '투자경고',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(text: ' 종목이에요\n'),
          TextSpan(text: '경고 사유를 확인 후 신중하게 거래하세요.')
        ],
      ),
    );
  }
}

class ManagementExceptText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: kExceptStyle,
        children: [
          TextSpan(text: '잠깐! '),
          TextSpan(
            text: '상장폐지',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(text: ' 우려가 있는 종목이에요\n'),
          TextSpan(text: '구매 의사가 있다면 참고해주세요.')
        ],
      ),
    );
  }
}
