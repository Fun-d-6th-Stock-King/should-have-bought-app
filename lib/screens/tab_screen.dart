import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/screens.dart'
    show MainScreen, DripRoomScreen, CardScreen, TodayWordScreen, MyPageScreen;
import 'package:should_have_bought_app/screens/main/calculator_result_screen.dart';
import 'package:should_have_bought_app/providers/admob/admob_provider.dart';

class TabScreen extends StatefulWidget {
  static const routeId = '/';

  final int selectIndex;
  TabScreen({@required this.selectIndex});
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedIndex = 0;
  List _screens;

  ListQueue<int> _navigationQueue = ListQueue();

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectIndex ?? 0;
    EasyLoading.instance.animationStyle = EasyLoadingAnimationStyle.scale;
    EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.threeBounce;
    EasyLoading.instance.loadingStyle = EasyLoadingStyle.light;
    EasyLoading.instance.backgroundColor = Colors.transparent;
    _screens = [
      MainScreen(),
      DripRoomScreen(),
      CardScreen(),
      TodayWordScreen(),
      MyPageScreen(),
    ];
    Provider.of<AdmobProvider>(context, listen: false).initAdmob(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_navigationQueue.isEmpty) return true;
        setState(() {
          _navigationQueue.removeLast();
          int position = _navigationQueue.isEmpty ? 0 : _navigationQueue.last;
          _selectedIndex = position;
        });
        return false;
      },
      child: Scaffold(
        backgroundColor: defaultBackgroundColor,
        body: Stack(
          children: [
            bodyContent,
            Positioned(left: 0, right: 0, bottom: 0, child: bottomNavigationBar)
          ],
        ),
        // bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }

  void _onTapped(int index) {
    if (index != _selectedIndex) {
      _navigationQueue.removeWhere((element) => element == index);
      _navigationQueue.addLast(index);
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Widget get bodyContent {
    return _screens[_selectedIndex];
  }

  Widget get bottomNavigationBar {
    return Container(
      height: 78.26,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(33), topLeft: Radius.circular(33)),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 2),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(33),
          topRight: Radius.circular(33),
        ),
        child: BottomNavigationBar(
          elevation: 10,
          backgroundColor: Color(0xFFFFFFFF),
          fixedColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(
              color: Color(0xFF333333),
              fontSize: 10.0,
              fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(
            color: Color(0xFF828282),
            fontSize: 10.0,
          ),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Image(
                    image: AssetImage('assets/icons/ico_main_unselect.png')),
                activeIcon: Image(
                    image: AssetImage('assets/icons/ico_main_select.png')),
                label: '홈'),
            BottomNavigationBarItem(
                icon: Image(
                    image: AssetImage('assets/icons/ico_drip_unselect.png')),
                activeIcon: Image(
                    image: AssetImage('assets/icons/ico_drip_select.png')),
                label: '드립방'),
            BottomNavigationBarItem(
              icon: Image(
                  image: AssetImage('assets/icons/ico_card_unselect.png')),
              activeIcon:
                  Image(image: AssetImage('assets/icons/ico_card_select.png')),
              label: '살까말까',
            ),
            // BottomNavigationBarItem(icon:Image(image: AssetImage('assets/icons/home_white.png')),label: '살말카드',backgroundColor: Color(0xFFFFB800)),
            BottomNavigationBarItem(
              icon: Image(
                  image: AssetImage('assets/icons/ico_word_unselect.png')),
              activeIcon:
                  Image(image: AssetImage('assets/icons/ico_word_select.png')),
              label: '오늘단어',
            ),
            BottomNavigationBarItem(
                icon: Image(
                    image: AssetImage('assets/icons/ico_mypage_unselect.png')),
                activeIcon: Image(
                    image: AssetImage('assets/icons/ico_mypage_select.png')),
                label: '마이페이지'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onTapped,
        ),
      ),
    );
  }
}
