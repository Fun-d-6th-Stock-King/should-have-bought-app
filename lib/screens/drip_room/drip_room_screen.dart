import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';
import 'package:should_have_bought_app/models/drip_room/evaluation_item.dart';
import 'package:should_have_bought_app/providers/drip_room/drip_room_provider.dart';
import 'package:should_have_bought_app/screens.dart';
import 'package:should_have_bought_app/screens/util/skeleton_widget.dart';
import 'package:should_have_bought_app/widgets/appbar/drip_room_appbar.dart';
import 'package:should_have_bought_app/screens/stock/stock_detail_screen.dart';
import 'package:should_have_bought_app/widgets/background/flat_background_frame.dart';
import 'package:should_have_bought_app/widgets/login/login_handler.dart';
import 'package:should_have_bought_app/widgets/text/prod_and_cons_widget.dart';

class DripRoomScreen extends StatefulWidget {
  @override
  _DripRoomScreenState createState() => _DripRoomScreenState();
}

class _DripRoomScreenState extends State<DripRoomScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
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
    // TODO: implement dispose
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      body: Consumer<DripRoomProvider>(
          child: emptyDripRoomScreen(context),
          builder: (context, dripRoomProvider, child) {
            List evaluationItemList = dripRoomProvider.evaluationItemList;
            return dripRoomProvider.evaluationItemList.length == 0
                ? child
                : Container(
                    margin: EdgeInsets.only(bottom: 100),
                    child: ListView.builder(
                        itemCount: evaluationItemList.length,
                        itemBuilder: (BuildContext context, int index) {
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

  Widget emptyDripRoomScreen(BuildContext context) {
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
              DripCardWidget(EvaluationItem(), _auth)
            ],
          ),
        )
      ],
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

class BestDripCardWidget extends StatefulWidget {
  @override
  _CreateBestDripCardWidgetState createState() =>
      _CreateBestDripCardWidgetState();
}

class _CreateBestDripCardWidgetState extends State<BestDripCardWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<DripRoomProvider>(context, listen: false).setIsLoading(true);
    Provider.of<DripRoomProvider>(context, listen: false).getTodayBest().then(
        (value) => setState(() =>
            Provider.of<DripRoomProvider>(context, listen: false)
                .setIsLoading(false)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Consumer<DripRoomProvider>(
          builder: (context, dripRoomProvider, child) {
        EvaluationItem evaluationItem = dripRoomProvider.todayBest;
        bool isLoadihg = dripRoomProvider.isLoading;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 13.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isLoadihg
                      ? skeletonText(100, 25)
                      : Text(
                          evaluationItem?.company ?? '',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      isLoadihg
                          ? skeletonText(40, 15)
                          : Text(
                              evaluationItem?.displayName ?? '',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  height: 17 / 12),
                            ),
                      isLoadihg
                          ? skeletonText(100, 15)
                          : Text(
                              evaluationItem?.createdDate ?? '',
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
            SizedBox(height: 9),
            Divider(
              color: Color(0xFF8E8E8E),
              thickness: 0.6,
            ),
            SizedBox(height: 9),
            Padding(
              padding: const EdgeInsets.only(left: 13.0),
              child: ProsAndConsWidget(
                pros: evaluationItem?.pros ?? '',
                cons: evaluationItem?.cons ?? '',
                isLoading: isLoadihg,
              ),
            )
          ],
        );
      }),
    );
  }
}
