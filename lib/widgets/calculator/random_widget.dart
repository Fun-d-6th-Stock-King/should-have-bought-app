import 'package:flutter/material.dart';

class RandomWidget extends StatefulWidget {
  final VoidCallback onTap;
  RandomWidget({@required this.onTap});

  @override
  _RandomWidgetState createState() => _RandomWidgetState();
}

class _RandomWidgetState extends State<RandomWidget> with SingleTickerProviderStateMixin{
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Column(
          children: [
            Image(image: AssetImage('assets/icons/ico_random.png')),
            Padding(padding: EdgeInsets.only(bottom: 2)),
            Text(
              '랜덤',
              style: TextStyle(fontSize: 11, color: Color(0xFF828282)),
            )
          ],
        ),
        onTap: () {
          if(widget.onTap != null) {
            widget.onTap();
          }
        }
    );
  }
}