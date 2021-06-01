import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';

class HeyToYouMoreScreen extends StatefulWidget {
  @override
  _CreateHeyToYouMoreScreenState createState() =>
      _CreateHeyToYouMoreScreenState();
}

class _CreateHeyToYouMoreScreenState extends State<HeyToYouMoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: AppBar(
        backgroundColor: defaultBackgroundColor,
        leading: InkWell(
            child: Icon(Icons.keyboard_arrow_left_outlined),
            onTap: () => Navigator.pop(context)),
        elevation: 0,
        actions: [
          Image(image: AssetImage("assets/icons/ico_refresh.png")),
        ],
        centerTitle: true,
        title: Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 25),
                          Text('다른 사람들은', style: HeyToYouMoreScreenHeaderStyle),
                          Text('어떤 종목을 후회중일까?',
                              style: HeyToYouMoreScreenHeaderStyle),
                          Text('다른 사람들의 검색결과를 최신순으로 확인해보세요!',
                              style: HeyToYouMoreScreenSubHeaderStyle),
                          SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: HeyToYouMoreCard(),
                          )
                        ]
                    )
                );
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: HeyToYouMoreCard(),
              );
            }),
      ),
    );
  }
}

class HeyToYouMoreCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Color(0xFFFF6B76),
      ),
      constraints: BoxConstraints(minHeight: 158),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('삼성전자',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            height: 23 / 16,
                            color: Colors.white,
                          )),
                      Padding(padding: EdgeInsets.only(right: 10)),
                      Text('1분전',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            height: 18 / 12,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('10년 전',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            height: 15 / 13,
                            color: Colors.white,
                          )),
                      Padding(padding: EdgeInsets.only(right: 10)),
                      Text('100,000원',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            height: 18 / 16,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13.0),
                  color: Colors.white,
                ),
                constraints: BoxConstraints(minHeight: 81),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('^ 395,820원',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                  height: 32 / 27,
                                  color: Color(0xFFFF6B76))),
                          Text('(+295%)',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                  height: 32 / 27,
                                  color: Color(0xFFFF6B76)))
                        ],
                      ),
                      Container(
                          height: 51,
                          child: VerticalDivider(
                            color: Color(0xFF8E8E8E),
                            width: 10,
                            thickness: 1,
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('현재가',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  height: 19 / 15,
                                  color: Colors.black)),
                          Text('18,380원/1주',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  height: 26 / 15,
                                  color: Colors.black))
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

const HeyToYouMoreScreenHeaderStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 26,
  height: 40 / 26,
);

const HeyToYouMoreScreenSubHeaderStyle =
    TextStyle(fontSize: 13, height: 19 / 13, color: Color(0xFF828282));
