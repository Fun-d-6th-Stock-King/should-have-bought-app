import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:should_have_bought_app/models/calculator/calculator_stock.dart';

class HeyYouToo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 213.0,
        viewportFraction: 0.7,
        enableInfiniteScroll: false,
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (context) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                color: Color(0xffF5F5F5),
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(left: 22, top: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '삼성전자',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '1분 전',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    SizedBox(height: 63),
                    Text('10년전보다'),
                    Text('+395,820원 (295%)'),
                    SizedBox(height: 10),
                    Container(
                      width: 125,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '현재가',
                            style: TextStyle(
                              color: Color(0xff6D6D6D),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            height: 10,
                            child: VerticalDivider(
                              width: 10,
                            ),
                          ),
                          Text(
                            '18,380원/1주',
                            style: TextStyle(
                              color: Color(0xff6D6D6D),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

// Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("그때 살걸... 야, 너두?",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w700,
//                       height: 1.5,
//                     )),
//                 Row(
//                   children: [
//                     Text("더보기",
//                         style: TextStyle(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w400,
//                             height: 1.5,
//                             color: Color(0xFF828282))),
//                     Icon(Icons.keyboard_arrow_right_outlined,
//                         color: Color(0xFF828282))
//                   ],
//                 ),
//               ],
//             ),

// children: <Widget>[
//     Container(
//       margin: EdgeInsets.only(
//         top: 20,
//         left: 20,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 '삼성전자',
//                 style: TextStyle(
//                     fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 width: 3,
//               ),
//               Text(
//                 '1분전',
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Color.fromARGB(255, 54, 54, 55),
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             margin: EdgeInsets.only(
//               right: 20,
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: <Widget>[
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Icon(
//                       CupertinoIcons.triangle_fill,
//                       size: 13,
//                       color: Color(0xffFF6561),
//                     ),
//                     SizedBox(
//                       height: 3,
//                     ),
//                   ],
//                 ),
//                 Text(
//                   '100,000원',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xffFF6561),
//                   ),
//                 ),
//                 (300 > 0)
//                     ? Text(
//                         '(+388%)',
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: Color(0xffFF6561),
//                         ),
//                       )
//                     : Text(
//                         '(-388%)',
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: Color(0xffFF6561),
//                         ),
//                       ),
//               ],
//             ),
//           )
//         ],
//       ),
//     ),
//     Container(
//       height: 78,
//       margin: EdgeInsets.symmetric(
//         horizontal: 17,
//         vertical: 15,
//       ),
//       decoration: BoxDecoration(
//         color: Color(0xffF4F4F4),
//         borderRadius: BorderRadius.all(
//           Radius.circular(8.0),
//         ),
//       ),
//       child: LayoutBuilder(builder: (build, constraint) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             Container(
//               width: constraint.maxWidth * 0.4,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     width: 53,
//                     height: 23,
//                     child: Text(
//                       '날짜',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     decoration: BoxDecoration(
//                         color: Color(0xff4F8AEF),
//                         borderRadius:
//                             BorderRadius.all(Radius.circular(20))),
//                   ),
//                   Container(
//                     child: Text(
//                       '100원',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Container(
//               width: constraint.maxWidth * 0.1,
//               height: 51,
//               child: VerticalDivider(
//                 color: Color(0xFF8E8E8E),
//               ),
//             ),
//             Container(
//               width: constraint.maxWidth * 0.4,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     width: 53,
//                     height: 23,
//                     child: Text(
//                       '현재가',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     decoration: BoxDecoration(
//                         color: Color(0xFFFFB800),
//                         borderRadius:
//                             BorderRadius.all(Radius.circular(20))),
//                   ),
//                   Container(
//                     child: Text(
//                       '100000/1주',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         );
//       }),
//     ),
//   ],
//
