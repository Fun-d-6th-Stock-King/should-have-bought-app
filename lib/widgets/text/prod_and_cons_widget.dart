import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/screens/util/skeleton_widget.dart';

class ProsAndConsWidget extends StatelessWidget {
  final String pros;
  final String cons;
  final bool isLoading;

  ProsAndConsWidget(
      {@required this.pros, @required this.cons, @required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 4, top: 1, bottom: 1, right: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: possibleColor,
              ),
              child: Text(
                '장점',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.white),
              ),
            ),
            SizedBox(width: 15),
            (isLoading != null && isLoading)
                ? skeletonText(80, 15)
                : Expanded(
              child: AutoSizeText(
                pros ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 20 / 14),
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
              padding: EdgeInsets.only(left: 4, top: 1, bottom: 1, right: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: nagativeColor,
              ),
              child: Text(
                '단점',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.white),
              ),
            ),
            SizedBox(width: 15),
            (isLoading != null && isLoading)
                ? skeletonText(80, 15)
                : Expanded(
              child: AutoSizeText(
                cons ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 20 / 14),
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