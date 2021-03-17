import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommenltCard extends StatefulWidget {
  @override
  _CommenltCardState createState() => _CommenltCardState();
}

class _CommenltCardState extends State<CommenltCard> {
  Widget _renderCommentCard(String comment) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Icon(CupertinoIcons.minus_rectangle),
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          comment,
          style: TextStyle(fontSize: 17),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return LayoutBuilder(
      builder: (context, constrains) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 3,
              color: Colors.grey[300],
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.52,
          width: (mediaQuery.size.width - mediaQuery.padding.left) * 0.90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(width: constrains.maxWidth * 0.1),
                  Container(
                    height: constrains.maxHeight * 0.1,
                    width: constrains.maxWidth * 0.5,
                    child:
                        // TODO : icon 으로 Emoji image parameter 전달 받아야 함
                        Icon(
                      Icons.thumb_up,
                      size: (mediaQuery.size.width * 0.3),
                    ),
                  ),
                  Container(
                    height: constrains.maxHeight * 0.2,
                    width: constrains.maxWidth * 0.2,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: IconButton(
                            icon: Icon(
                              CupertinoIcons.heart,
                              size: (mediaQuery.size.width * 0.08),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Text(
                          // TODO : Parameter로 Like 수 전달 받아야 함
                          '1,234',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            // TODO : Child로 로고 이미지 전달받아야함
                            backgroundColor: Colors.blue,
                            radius: (mediaQuery.size.width * 0.05),
                          ),
                        ),
                        Text(
                          // TODO : Parameter 전달받아야 함
                          '삼성전자',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _renderCommentCard('망해도 국가가 살려줄 국민주'),
                    SizedBox(
                      height: 5,
                    ),
                    _renderCommentCard('내가 벌때 쟤도 범'),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '2021-03-04',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      '아빠 왜 그때 안샀어...',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        '댓글 N개 모두보기',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
