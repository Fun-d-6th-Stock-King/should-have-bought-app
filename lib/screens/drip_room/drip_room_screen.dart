import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/widgets/appbar/default_appbar.dart';
import 'package:should_have_bought_app/widgets/appbar/drip_room_appbar.dart';

class DripRoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin:EdgeInsets.only(bottom: 100),
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              if(index == 0) {
                return DripRoomWidget();
              }
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                margin: EdgeInsets.only(bottom: 15),
                child: BestDripCardWidget(),
              );
          }
        ),
      ),
    );
  }
}

class DripRoomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(children: [
          Container(
            height: 225,
            decoration: BoxDecoration(
              color: mainColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                DripRoomAppBar(context),
                SizedBox(height: 33),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Today's BEST",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 9),
                BestDripCardWidget(),
              ],
            ),
          )
        ]),
        SizedBox(height: 37),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('최신순'),
                  Icon(Icons.keyboard_arrow_down_outlined)
                ],
              ),
              SizedBox(height: 11),
              DripCardWidget()
            ],
          ),
        )
      ],
    );
  }
}

class DripCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 26),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'SK 바이오',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '닉네임',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: 17 / 12),
                    ),
                    Text(
                      '32,547',
                      style:
                          TextStyle(fontSize: 11, color: Color(0xFF828282)),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 6),
            Divider(
              color: Color(0xFF8E8E8E),
              thickness: 0.6,
            ),
            SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: ProsAndConsWidget(),
            ),
          ],
        ));
  }
}

class BestDripCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '박셀 바이오',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '닉네임',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: 17 / 12),
                    ),
                    Text(
                      '2020-03-04',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF828282)),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 11),
          Divider(
            color: Color(0xFF8E8E8E),
            thickness: 0.6,
          ),
          SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: ProsAndConsWidget(),
          )
        ],
      ),
    );
  }
}

class ProsAndConsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: possibleColor,
              ),
              child: Text(
                '장점',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    height: 17 / 12,
                    color: Colors.white),
              ),
            ),
            SizedBox(width: 11),
            Text(
              '망해도 국가가 살려줄 국민주',
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: 14, height: 20 / 14),
            )
          ],
        ),
        SizedBox(
          height: 9,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: nagativeColor,
              ),
              child: Text(
                '단점',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    height: 17 / 12,
                    color: Colors.white),
              ),
            ),
            SizedBox(width: 11),
            Text(
              '내가 벌떄 쟤도 범',
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: 14, height: 20 / 14),
            )
          ],
        )
      ],
    );
  }
}
