import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';
import 'package:should_have_bought_app/models/drip_room/evaluation_item.dart';
import 'package:should_have_bought_app/providers/drip_room/drip_room_provider.dart';
import 'package:should_have_bought_app/screens/stock/stock_detail_screen.dart';
import 'package:should_have_bought_app/widgets/login/login_handler.dart';
import 'package:should_have_bought_app/widgets/text/prod_and_cons_widget.dart';

class DripCardWidget extends StatelessWidget {
  final EvaluationItem evaluationItem;
  final FirebaseAuth _auth;

  DripCardWidget(this.evaluationItem, this._auth);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StockDetailScreen(
                    Company(
                        company: evaluationItem.company ?? '',
                        code: evaluationItem.code ?? ''),
                    1)));
      },
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 26),
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      evaluationItem.company ?? '',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () async {
                        _auth.currentUser == null
                            ? LoginHandler(context)
                            : await Provider.of<DripRoomProvider>(context,
                                    listen: false)
                                .likeDrip(evaluationItem);
                      },
                      child: Column(
                        children: [
                          SizedBox(
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
                          Text(evaluationItem.likeCount.toString(),
                              style: TextStyle(
                                  color: mainColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Color(0xFF8E8E8E),
                thickness: 0.6,
              ),
              SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.only(left: 13.0),
                child: ProsAndConsWidget(
                  pros: evaluationItem?.pros ?? '',
                  cons: evaluationItem?.cons ?? '',
                ),
              ),
            ],
          )),
    );
  }
}
