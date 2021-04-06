import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeyYouToo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  left: 25,
                  bottom: 10,
                ),
                width: 172,
                height: 31,
                child: Text(
                  '그때 살걸...야, 너두?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  right: 20,
                  bottom: 10,
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    '더보기 >',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF828282),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          width: 320,
          height: 158,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 1),
                )
              ]),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                  left: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '삼성전자',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          '1분전',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 54, 54, 55),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        right: 20,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Icon(
                            CupertinoIcons.triangle_fill,
                            size: 13,
                            color: Color(0xffFF6561),
                          ),
                          Text(
                            '395,820원',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffFF6561),
                            ),
                          ),
                          Text(
                            '(+295%)',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xffFF6561),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: 286,
                height: 78,
                margin: EdgeInsets.symmetric(
                  horizontal: 17,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: Color(0xffF4F4F4),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                child: LayoutBuilder(builder: (build, constraint) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: constraint.maxWidth * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 53,
                              height: 23,
                              child: Text(
                                '10년전',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xff4F8AEF),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                            Container(
                              child: Text(
                                '100,000원',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: constraint.maxWidth * 0.1,
                        height: 51,
                        child: VerticalDivider(
                          color: Color(0xFF8E8E8E),
                        ),
                      ),
                      Container(
                        width: constraint.maxWidth * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 53,
                              height: 23,
                              child: Text(
                                '현재가',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xFFFFB800),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                            Container(
                              child: Text(
                                '18,380원/1주',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        )
      ],
    );
  }
}
