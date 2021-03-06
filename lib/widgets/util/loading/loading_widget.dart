import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> with SingleTickerProviderStateMixin{
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RotationTransition(
          turns: Tween(begin: 0.0, end: 4.0).animate(
              CurvedAnimation(
                parent: _controller,
                curve: Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
              )),
          child: Image(image: AssetImage('assets/icons/ico_loading.png')),
        ),
        Padding(padding: EdgeInsets.only(bottom: 2)),
      ],
    );
  }
}