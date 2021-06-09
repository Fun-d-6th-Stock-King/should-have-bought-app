import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/widgets/mypage/temp_widget.dart';

class EditProfileBottomSheet extends StatefulWidget {
  @override
  _EditProfileBottomSheetState createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  int _currentContent = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        height: 420,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            Container(
              height: 150,
              child: TempWidget(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [1, 2, 3, 4].map((url) {
                int index = [1, 2, 3, 4].indexOf(url);
                return Container(
                  width: _currentContent == index ? 32 : 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
                  decoration: BoxDecoration(
                    borderRadius: _currentContent == index
                        ? BorderRadius.circular(20.0)
                        : BorderRadius.circular(100.0),
                    color: _currentContent == index
                        ? mainColor
                        : Color(0xFFDFDFDF),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
