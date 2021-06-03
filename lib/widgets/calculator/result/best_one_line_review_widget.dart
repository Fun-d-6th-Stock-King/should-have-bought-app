import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/widgets/text/prod_and_cons_widget.dart';

class BestOneLineReviewWidget extends StatefulWidget {
  @override
  _BestOneLineReviewWidgetState createState() =>
      _BestOneLineReviewWidgetState();
}

class _BestOneLineReviewWidgetState extends State<BestOneLineReviewWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            'BEST 한줄평',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13.0),
            color: Color(0xFFAEAEAE).withOpacity(0.16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                          bottom: 13.0,
                          left: 20.0,
                          right: 20.0,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '박기현',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 17 / 12),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              height: 13,
                              child: VerticalDivider(
                                color: Color(0xFF8E8E8E).withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            Text(
                              '12분 전',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xFF828282)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(
                                  left: 4, top: 1, bottom: 1, right: 2),
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
                            SizedBox(width: 15),
                            AutoSizeText(
                              '망해도 국가가 살려줄 국민주',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  height: 20 / 14),
                              presetFontSizes: [14, 13],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(
                                  left: 4, top: 1, bottom: 1, right: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: nagativeColor,
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
                            SizedBox(width: 15),
                            AutoSizeText(
                              '내가 벌때 쟤도 범',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  height: 20 / 14),
                              presetFontSizes: [14, 13],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 18.0, right: 20.0),
                child: Column(
                  children: [
                    InkWell(
                      // onTap: () => _auth.currentUser == null
                      //     ? LoginHandler(context)
                      //     : Provider.of<TodayWordProvider>(context,
                      //             listen: false)
                      //         .likeWord(wordItem),
                      onTap: () {},
                      child: SizedBox(
                        width: 36,
                        height: 36,
                        child: ClipOval(
                          child: Container(
                            color: mainColor,
                            child: Image(
                              image: AssetImage(
                                'assets/icons/ico_heart.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      '1234',
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
