import 'package:flutter/material.dart';

class RandomWidget extends StatefulWidget {
  final VoidCallback onTap;
  final Color color;
  RandomWidget({@required this.onTap, this.color = Colors.black});

  @override
  _RandomWidgetState createState() => _RandomWidgetState();
}

class _RandomWidgetState extends State<RandomWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          padding: EdgeInsets.only(top: 7),
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/icons/ico_random.png'),
                color: widget.color,
              ),
              Padding(padding: EdgeInsets.only(bottom: 2)),
              Text(
                '랜덤',
                style: TextStyle(fontSize: 11, color: widget.color),
              )
            ],
          ),
        ),
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap();
          }
        });
  }
}
