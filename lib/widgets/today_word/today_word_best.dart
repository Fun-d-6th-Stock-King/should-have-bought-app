import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';

class TodayWordBest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Color.fromRGBO(255, 184, 0, 0.1),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top:15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('니주니알', style: TextStyle(
                          fontSize: 23, height: 33/23,fontWeight: FontWeight.w500
                        ),),
                        SizedBox(width: 11,),
                        Text('닉네임', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 20/14, color:Color(0xFF828282)),),
                        SizedBox(width: 2),
                        Text('|', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 20/14, color:Color(0xFF828282)),),
                        SizedBox(width: 2,),
                        Text('2일전', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, height: 20/14, color:Color(0xFF828282)),),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 28,
                          height: 28,
                          child: ClipOval(
                            child: Container(
                              color: mainColor,
                              child: Image(image: AssetImage('assets/icons/ico_heart.png')),
                            ),
                            ),
                          ),
                        Text('245', style: TextStyle(color: mainColor, fontSize: 11, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text("'니 주식 니가 알지'\n본인 종목에 대한 분석과 정보수집을 스스로 하지 않고\n끊임없이 타인에게 의존하는 사람에게 쓰는 말",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12,height: 17/12),),
                SizedBox(height: 22),
              ],
            ),
          ),
          Container(
            height: 41,
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 184, 0, 0.15),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.0), bottomRight: Radius.circular(12.0))
            ),
            alignment: Alignment.center,
            child: Text('내일의 주식단어 추천하러 가기 >', style: TextStyle(
                color:Color(0xFFFF9900), fontSize: 13, fontWeight: FontWeight.w500
            ),
            ),
          )
        ],
      ),
    );
  }
}
