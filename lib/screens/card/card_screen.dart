import 'package:flutter/material.dart';
import 'package:should_have_bought_app/widgets/card/lib/swipe_cards.dart';


class CardScreen extends StatefulWidget  {
  @override
  _CreateCardScreen createState() => _CreateCardScreen();
}
class _CreateCardScreen extends State<CardScreen> with SingleTickerProviderStateMixin{
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            RotationTransition(
              turns: Tween(begin: 0.0, end: 5.0).animate(_controller),
              child: Image(image: AssetImage('assets/icons/ico_random.png')),
            ),
            RaisedButton(
              child: Text("go"),
              onPressed: () => _controller.forward(),
            ),
            RaisedButton(
              child: Text("stop"),
              onPressed: () => _controller.reset(),
            ),
          ],
        ),
      ),
    );
  }
}

class Content {
  final String text;
  final Color color;

  Content({this.text, this.color});
}
