import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'package:should_have_bought_app/providers/drip_room/drip_room_provider.dart';
import 'package:should_have_bought_app/widgets/appbar/drip_room_appbar.dart';
import 'package:should_have_bought_app/widgets/background/flat_background_frame.dart';
import 'package:should_have_bought_app/widgets/drip_room/best_drip_card_widget.dart';
import 'package:should_have_bought_app/widgets/drip_room/drip_card_widget.dart';
import 'package:should_have_bought_app/widgets/drip_room/empty_drip_room_screen_widget.dart';

class DripRoomScreen extends StatefulWidget {
  @override
  _DripRoomScreenState createState() => _DripRoomScreenState();
}

class _DripRoomScreenState extends State<DripRoomScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    Map<String, dynamic> parmeters = {
      'order': 'LATELY',
      'pageNo': '1',
      'pageSize': '100'
    };

    await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.none,
    );
    Provider.of<DripRoomProvider>(context, listen: false)
        .getEvaluationList(parmeters)
        .then((value) => EasyLoading.dismiss());
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      body: Consumer<DripRoomProvider>(
          child: EmptyDripRoomScreen(auth: _auth, context: context),
          builder: (context, dripRoomProvider, child) {
            List evaluationItemList = dripRoomProvider.evaluationItemList;
            return dripRoomProvider.evaluationItemList.isEmpty
                ? child
                : Container(
                    margin: EdgeInsets.only(bottom: 100),
                    child: ListView.builder(
                        itemCount: evaluationItemList.length,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Column(
                              children: [
                                FlatBackgroundFrame(child: DripRoomWidget()),
                                SizedBox(height: 37),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text('최신순'),
                                          Icon(Icons
                                              .keyboard_arrow_down_outlined)
                                        ],
                                      ),
                                      SizedBox(height: 11),
                                      DripCardWidget(
                                          evaluationItemList[index], _auth)
                                    ],
                                  ),
                                )
                              ],
                            );
                          }
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: DripCardWidget(
                                evaluationItemList[index], _auth),
                          );
                        }),
                  );
          }),
    );
  }
}

class DripRoomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
