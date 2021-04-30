import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/widgets.dart';
import 'package:should_have_bought_app/widgets/hey_you_too/hey_you_too.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("닉네임",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                            color: mainColor,
                          )),
                      Text(" 님,",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              height: 1.5)),
                    ],
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://www.woolha.com/media/2020/03/eevee.png'),
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
              Text("오늘도 익절하는 하루 되세요.",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500, height: 1.5)),
              SizedBox(
                height: 21,
              ),
              // add 계산기
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("메인편집",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                          color: mainColor)),
                  //Icon(Icons.fiber_manual_record_rounded, color: Color(0xFF828282))
                ],
              ),
              SizedBox(
                height: 7,
              ),
              CalculatorWidget(),
              // SizedBox(
              //     height: 340,
              //     child: Card(
              //       elevation: 0.4,
              //
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(15.0),
              //       ),
              //       child: Padding(
              //         padding: EdgeInsets.symmetric(horizontal: 18.0),
              //         child: Container(),
              //       ),
              //     )
              // ),
              SizedBox(
                height: 60,
              ),
              HeyYouToo(),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                  height: 164,
                  child: Card(
                    elevation: 0.4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Container(),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 164,
                  child: Card(
                    elevation: 0.4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Container(),
                    ),
                  )),
              SizedBox(
                height: 66,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("현재 주가",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                      )),
                  Row(
                    children: [
                      Text("인기순",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                              color: Color(0xFF828282))),
                      Icon(Icons.keyboard_arrow_down_outlined,
                          color: Color(0xFF828282))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
