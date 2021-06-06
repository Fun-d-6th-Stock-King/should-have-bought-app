import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';

class EditProfileBottomSheet extends StatelessWidget {
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
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 150,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.5,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                ),
                items: <Widget>[
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150.0),
                      border: Border.all(
                        color: mainColor,
                        width: 3.0,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: defaultBackgroundColor,
                      child: Image(
                        image: AssetImage('assets/images/normal_chick.png'),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150.0),
                      border: Border.all(
                        color: mainColor,
                        width: 3.0,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: defaultBackgroundColor,
                      child: Image(
                        image: AssetImage('assets/images/normal_chick.png'),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150.0),
                      border: Border.all(
                        color: mainColor,
                        width: 3.0,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: defaultBackgroundColor,
                      child: Image(
                        image: AssetImage('assets/images/normal_chick.png'),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150.0),
                      border: Border.all(
                        color: mainColor,
                        width: 3.0,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: defaultBackgroundColor,
                      child: Image(
                        image: AssetImage('assets/images/normal_chick.png'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
