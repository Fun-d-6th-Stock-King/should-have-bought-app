import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/drip_room/evaluation_item.dart';

class DripRoomDetailScreen extends StatefulWidget {
  final EvaluationItem evaluationItem;
  DripRoomDetailScreen(this.evaluationItem);
  @override
  _DripRoomDetailScreenState createState() => _DripRoomDetailScreenState();
}
class _DripRoomDetailScreenState extends State<DripRoomDetailScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultBackgroundColor,
        leading: null,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.evaluationItem.company),
      ),
      body: Container(
        child: Text('hallo'),
      ),
    );
  }
}
