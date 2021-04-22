import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/screens.dart'
    show MainScreen, BuyOrNotScreen, CardScreen, TodayWordScreen, MyPageScreen;
import 'package:should_have_bought_app/screens/main/calculator_result_screen.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedIndex = 0;
  List _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      MainScreen(),
      BuyOrNotScreen(),
      CardScreen(),
      TodayWordScreen(),
      MyPageScreen(),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      body: Stack(
        children: [
          bodyContent,
          Positioned(left: 0, right: 0, bottom: 0, child: bottomNavigationBar)
        ],
      ),
      //bottomNavigationBar: bottomNavigationBar,
    );
  }

  void _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget get bodyContent {
    return _screens[_selectedIndex];
  }

  Widget get bottomNavigationBar {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(33),
        topRight: Radius.circular(33),
      ),
      child: SizedBox(
        height: 78.26,
        child: BottomNavigationBar(
          elevation: 10,
          backgroundColor: Colors.white,
          fixedColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedLabelStyle: TextStyle(
              color: Colors.black, fontSize: 10.0, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(
            color: Colors.black,
            fontSize: 10.0,
          ),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Image(image: AssetImage('assets/icons/home.png')),
                label: '메인'),
            BottomNavigationBarItem(
                icon: Image(image: AssetImage('assets/icons/Card.png')),
                label: '이거살말'),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: mainColor,
                ),
                child: Image(image: AssetImage('assets/icons/home_white.png')),
              ),
              label: '살말카드',
            ),
            // BottomNavigationBarItem(icon:Image(image: AssetImage('assets/icons/home_white.png')),label: '살말카드',backgroundColor: Color(0xFFFFB800)),
            BottomNavigationBarItem(
                icon: Image(image: AssetImage('assets/icons/atm_location.png')),
                label: '오늘의단어'),
            BottomNavigationBarItem(
                icon: Image(image: AssetImage('assets/icons/Profile.png')),
                label: 'MY'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onTapped,
        ),
      ),
    );
  }
}
