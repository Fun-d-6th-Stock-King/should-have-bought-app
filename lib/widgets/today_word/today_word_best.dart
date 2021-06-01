import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/today_word/word_item.dart';
import 'package:should_have_bought_app/providers/today_word/today_word_provider.dart';

class TodayWordBest extends StatefulWidget {
  @override
  _CreateTodayWordBestState createState() => _CreateTodayWordBestState();
}
class _CreateTodayWordBestState extends State<TodayWordBest> {

  @override
  void didChangeDependencies() async{
    await Provider.of<TodayWordProvider>(context, listen:false).getTodayBest();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Color.fromRGBO(255, 184, 0, 0.1),
      ),
      constraints: BoxConstraints(
          minHeight: 170
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top:15),
            child: Consumer<TodayWordProvider>(
              builder: (context, todayWordProvider, child) {
                WordItem wordItem = todayWordProvider.todayBest;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(wordItem.wordName, style: TextStyle(
                              fontSize: 23, height: 33/23,fontWeight: FontWeight.w500
                            ),),
                            SizedBox(width: 11,),
                            Text(wordItem.displayName, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 20/14, color:Color(0xFF828282)),),
                            SizedBox(width: 2),
                            Text('|', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 20/14, color:Color(0xFF828282)),),
                            SizedBox(width: 2,),
                            Text(wordItem.createdDateText, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, height: 20/14, color:Color(0xFF828282)),),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: 28,
                              height: 28,
                              child: ClipOval(
                                child: Container(
                                  color: mainColor,
                                  child: Image(image: AssetImage('assets/icons/ico_heart.png')),
                                ),
                                ),
                              ),
                            Text(wordItem.likeCount.toString(), style: TextStyle(color: mainColor, fontSize: 11, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    AutoSizeText(
                      wordItem.mean,
                      style:TextStyle(fontWeight: FontWeight.w500, fontSize: 12,height: 17/12),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 22),
                  ],
                );
              }
            ),
          ),
          Container(
            height: 41,
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 184, 0, 0.15),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.0), bottomRight: Radius.circular(12.0))
            ),
            alignment: Alignment.center,
            child: Text('내일의 주식단어 추천하러 가기 >', style: TextStyle(
                color:Color(0xFFFF9900), fontSize: 13, fontWeight: FontWeight.w500
            ),
            ),
          )
        ],
      ),
    );
  }
}
