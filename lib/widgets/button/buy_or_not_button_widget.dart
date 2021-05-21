import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';

class BuyOrNotButtonWidget extends StatefulWidget{
  String type;
  int value;
  VoidCallback onTap;
  bool isChecked;
  // type = "BUY" , "SELL"
  BuyOrNotButtonWidget({@required this.type, @required this.value, @required this.onTap, this.isChecked = false});
  @override
  _CreateBuyOrNotButtonState createState() => _CreateBuyOrNotButtonState();
}

class _CreateBuyOrNotButtonState extends State<BuyOrNotButtonWidget> {
  Image _image;
  Color _color;
  String _title;
  bool _isChecked;
  @override
  void initState() {
    super.initState();
    if(widget.type == "BUY") {
      _image = Image(image: AssetImage('assets/icons/ico_like_big.png'));
      _color = likeColor;
      _title = "살래?";
    }
    if(widget.type == "SELL"){
      _image = Image(image: AssetImage('assets/icons/ico_unlike_big.png'));
      _color = nagativeColor;
      _title = "말래?";
    }
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //setState(() =>_isChecked = !_isChecked);
        widget.onTap();
      },
      child:Wrap(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: ClipOval(
                  child: Container(
                    color: widget.isChecked == true ? _color : disableColor,
                    padding: EdgeInsets.only(bottom: widget.type == "BUY" ? 5 : 0),
                    child: _image,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  height: 20 / 14,
                  color: _color,
                ),
              ),
              Text("${widget.value.toString()}",
                  style: buyOrNotCountTextStyle),
            ],
          ),
        ],
      ),
    );
  }
}