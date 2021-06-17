import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:should_have_bought_app/models/drip_room/evaluation_item.dart';
import 'package:should_have_bought_app/widgets/appbar/drip_room_appbar.dart';
import 'package:should_have_bought_app/widgets/background/flat_background_frame.dart';
import 'package:should_have_bought_app/widgets/drip_room/drip_card_widget.dart';

class EmptyDripRoomScreen extends StatelessWidget {
  final FirebaseAuth auth;
  final BuildContext context;
  const EmptyDripRoomScreen({this.auth, this.context});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlatBackgroundFrame(
            child: Padding(
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
                  ],
                ))),
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
              DripCardWidget(EvaluationItem(), auth)
            ],
          ),
        )
      ],
    );
  }
}
