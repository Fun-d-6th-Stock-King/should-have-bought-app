import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/models/drip_room/evaluation_item.dart';
import 'package:should_have_bought_app/providers/drip_room/drip_room_provider.dart';
import 'package:should_have_bought_app/screens/util/skeleton_widget.dart';
import 'package:should_have_bought_app/widgets/text/prod_and_cons_widget.dart';

class TodayBestDripCardWidget extends StatefulWidget {
  @override
  _CreateBestDripCardWidgetState createState() =>
      _CreateBestDripCardWidgetState();
}

class _CreateBestDripCardWidgetState extends State<TodayBestDripCardWidget> {
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
