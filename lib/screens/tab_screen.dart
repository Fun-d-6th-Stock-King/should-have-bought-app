import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:should_have_bought_app/screens.dart' show MainScreen, BuyOrNotScreen, CardScreen, TodayWordScreen, MyPageScreen;

class TabScreen extends StatefulWidget {

  @override
  _TabScreenState createState() =>_TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedIndex = 0;
  List _screens;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
    print('[auth]');
    test();
  }

  void test() async {
    final user = await _auth.currentUser;
    print(user);
    final idToken = await user.getIdToken();
    print(idToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        fixedColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
          color: Colors.black,
          fontSize: 10.0,
          fontWeight: FontWeight.bold
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.black,
          fontSize: 10.0,
        ),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon:Icon(Icons.home),label: '메인'),
          BottomNavigationBarItem(icon:Icon(Icons.shopping_basket),label: '이거살말'),
          BottomNavigationBarItem(icon:Icon(Icons.credit_card),label: '살말카드'),
          BottomNavigationBarItem(icon:Icon(Icons.adb),label: '오늘의단어'),
          BottomNavigationBarItem(icon:Icon(Icons.person),label: 'MY'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onTapped,
      )
    );
  }

  void _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}