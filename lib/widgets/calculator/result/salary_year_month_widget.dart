import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/utils.dart';

class SalaryYearMonthWidget extends StatelessWidget {
  final String salaryYear;
  final String salaryMonth;

  SalaryYearMonthWidget({this.salaryYear, this.salaryMonth});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            '연봉/월급으로 친다면?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          height: 18,
        ),
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
                    AutoSizeText(
                      '1년에',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff828282),
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      numberWithComma(salaryYear),
                      style: kSalaryTextStyle,
                      maxLines: 1,
                      minFontSize: 10,
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
                      '1달에',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff828282),
                      ),
                    ),
                    AutoSizeText(
                      numberWithComma(salaryMonth),
                      style: kSalaryTextStyle,
                      maxLines: 1,
                      minFontSize: 10,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
