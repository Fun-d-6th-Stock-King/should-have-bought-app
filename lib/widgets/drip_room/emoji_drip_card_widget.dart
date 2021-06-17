import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/buy_or_not/stock_evaluation_item.dart';
import 'package:should_have_bought_app/providers/drip_room/drip_room_provider.dart';
import 'package:should_have_bought_app/widgets/login/login_handler.dart';
import 'package:should_have_bought_app/widgets/text/prod_and_cons_widget.dart';

class EmojiDripCardWidget extends StatelessWidget {
  final StockEvaluationItem evaluationItem;
  final FirebaseAuth auth;

  EmojiDripCardWidget(this.evaluationItem, this.auth);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
              width: size.width * 0.9,
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 15, bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: size.width * 0.25),
                          child: CircleAvatar(
                            backgroundColor:
                                Color(0XFFCECECE).withOpacity(0.16),
                            radius: 50.0,
                            child: Text(
                              evaluationItem?.giphyImgId ?? '', //이모티콘
                              style: TextStyle(
                                fontSize: 52,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(width: size.width * 0.18),
                        Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                auth.currentUser == null
                                    ? LoginHandler(context)
                                    : await Provider.of<DripRoomProvider>(
                                            context,
                                            listen: false)
                                        .likeDripEmoji(evaluationItem.id);
                              },
                              child: SizedBox(
                                width: 28,
                                height: 28,
                                child: ClipOval(
                                  child: Container(
                                    color: evaluationItem.userlike == true
                                        ? mainColor
                                        : kGreyColor,
                                    child: Image(
                                        image: AssetImage(
                                            'assets/icons/ico_heart.png')),
                                  ),
                                ),
                              ),
                            ),
                            Text(evaluationItem.likeCount.toString(),
                                style: TextStyle(
                                    color: mainColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 13.0),
                        ),
                        Text(
                          evaluationItem?.displayName ?? '',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: 17 / 12),
                        ),
                        VerticalDivider(
                          color: Color(0xFF8E8E8E),
                          thickness: 0.6,
                        ),
                        Text(
                          evaluationItem?.createdDate ?? '',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w300,
                              color: Color(0xFF828282)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.only(left: 13.0),
                    child: ProsAndConsWidget(
                      pros: evaluationItem?.pros ?? '',
                      cons: evaluationItem?.cons ?? '',
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              )),
        ],
      ),
    );
  }
}
