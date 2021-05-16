import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/drip_room/evaluation_item.dart';
import 'package:should_have_bought_app/providers/drip_room/drip_room_provider.dart';
import 'package:should_have_bought_app/widgets/appbar/drip_room_appbar.dart';
import 'package:should_have_bought_app/screens/stock/stock_detail_screen.dart';
import 'package:should_have_bought_app/widgets/background/flat_background_frame.dart';

class DripRoomScreen extends StatefulWidget {
  @override
  _DripRoomScreenState createState() => _DripRoomScreenState();
}
class _DripRoomScreenState extends State<DripRoomScreen> {

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Map<String, dynamic> parmeters = {'order':'LATELY','pageNo':'1', 'pageSize':'100'};
    bool isEmpty = Provider.of<DripRoomProvider>(context, listen:false).evaluationItemList.length == 0 ? true : false;
    if(isEmpty) {
      Provider.of<DripRoomProvider>(context, listen: false)
          .getEvaluationList(parmeters);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      body: Consumer<DripRoomProvider>(
        builder: (context, dripRoomProvider, child) {
          List evaluationItemList = dripRoomProvider.evaluationItemList;
          return Container(
            margin:EdgeInsets.only(bottom: 100),
            child: ListView.builder(
                itemCount: evaluationItemList.length,
                itemBuilder: (BuildContext context, int index) {
                  if(index == 0) {
                    return Column(
                      children: [
                        FlatBackgroundFrame(
                            child: DripRoomWidget()
                        ),
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
                              DripCardWidget(evaluationItemList[index])
                            ],
                          ),
                        )
                      ],
                    );
                  }
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DripCardWidget(evaluationItemList[index]),
                  );
              }
            ),
          );
        }
      ),
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
  DripCardWidget(this.evaluationItem);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => StockDetailScreen(evaluationItem,1)));
      },
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 26),
          margin : const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      evaluationItem.company,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2, right: 4),
                          child: Image(image: AssetImage('assets/icons/ico_like.png')),
                        ),
                        Text(
                          evaluationItem.likeCount.toString(),
                          style:
                              TextStyle(fontSize: 11, color: Color(0xFF828282)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6),
              Divider(
                color: Color(0xFF8E8E8E),
                thickness: 0.6,
              ),
              SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.only(left: 13.0),
                child: ProsAndConsWidget(
                  pros: evaluationItem.pros,
                  cons: evaluationItem.cons,
                ),
              ),
            ],
          )),
    );
  }
}
class BestDripCardWidget extends StatefulWidget {
  @override
  _CreateBestDripCardWidgetState createState() => _CreateBestDripCardWidgetState();
}
class _CreateBestDripCardWidgetState extends State<BestDripCardWidget> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<DripRoomProvider>(context, listen: false).getTodayBest();
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
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      evaluationItem?.company ?? '',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          evaluationItem?.displayName ?? '',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: 17 / 12),
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
                ),
              )
            ],
          );
        }
      ),
    );
  }
}

class ProsAndConsWidget extends StatelessWidget {
  final String pros;
  final String cons;
  ProsAndConsWidget({@required this.pros, @required this.cons});

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
            Expanded(
              child: AutoSizeText(
                pros ?? '',
                style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 14, height: 20 / 14),
                presetFontSizes: [14, 13],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
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
            Expanded(
              child: AutoSizeText(
                cons ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.w400, fontSize: 14, height: 20 / 14),
                presetFontSizes: [14, 13],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        )
      ],
    );
  }
}
