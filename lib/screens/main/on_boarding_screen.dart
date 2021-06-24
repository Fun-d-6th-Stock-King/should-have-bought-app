import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/widgets/login/google_login_button.dart';
import 'package:should_have_bought_app/widgets/login/kakao_login_button.dart';
import 'package:should_have_bought_app/widgets/login/login_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  static const routeId = '/on-boarding';
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }

  Widget _buildFullscrenImage(String assetName) {
    return Image.asset(
      'assets/$assetName',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.9);
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      pageColor: Colors.transparent,
      imageAlignment: Alignment.center,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: '',
          image: _buildFullscrenImage('images/on_boarding_1.png'),
          body: "",
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            imageFlex: 1,
          ),
        ),
        PageViewModel(
          title: '',
          image: _buildFullscrenImage('images/on_boarding_2.png'),
          body: "",
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 2,
            imageFlex: 3,
          ),
        ),
        PageViewModel(
          title: '',
          image: _buildFullscrenImage('images/on_boarding_3.png'),
          body: '',
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 2,
            imageFlex: 3,
          ),
        ),
        PageViewModel(
          title: '',
          image: _buildFullscrenImage('images/on_boarding_4.png'),
          body: '',
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 2,
            imageFlex: 3,
          ),
        ),
        PageViewModel(
          title: '',
          image: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                child: Image.asset(
                  'assets/icons/main_icon.png',
                  height: 78,
                  width: 78,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              GoogleLoginButton(onPressed: () {
                _onIntroEnd(context);
              }),
              SizedBox(height: 5),
              KakaoLoginButton(onPressed: () {
                _onIntroEnd(context);
              }),
              SizedBox(height: 5),
            ],
          ),
          body: '',
          decoration: pageDecoration.copyWith(
            fullScreen: true,
          ),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showDoneButton: true,
      showNextButton: false,
      showSkipButton: false,
      dotsFlex: 2,
      done: const Text(
        '둘러보기',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: mainColor,
          fontSize: 14,
        ),
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(8),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: mainColor,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
