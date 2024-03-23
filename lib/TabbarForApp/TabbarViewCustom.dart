import 'package:flutter/material.dart';
import 'package:flutter_application_134/TabbarForApp/HomeScreen.dart';

class TabbarViewCustom extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TabbarViewCustom> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    Page2(),
    Page3(),
    Page4(),
    Page5(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(index);
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: _pages[_selectedIndex],
    bottomNavigationBar: BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Image.asset('/Users/risalat/Documents/flutter_application_134/web/ic_off_menu@3x.png', width: 24, height: 24),
          activeIcon: Image.asset('/Users/risalat/Documents/flutter_application_134/web/ic_on_menu@3x.png', width: 24, height: 24),
          label: 'HOME',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('/Users/risalat/Documents/flutter_application_134/web/ic_off_cart@3x.png', width: 24, height: 24),
          activeIcon: Image.asset('/Users/risalat/Documents/flutter_application_134/web/ic_on_cart@3x.png', width: 24, height: 24),
          label: 'CART',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('/Users/risalat/Documents/flutter_application_134/web/ic_off_rewards@3x.png', width: 24, height: 24),
          activeIcon: Image.asset('/Users/risalat/Documents/flutter_application_134/web/ic_on_rewards@3x.png', width: 24, height: 24),
          label: 'REWARDS',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('/Users/risalat/Documents/flutter_application_134/web/ic_off_stores@3x.png', width: 24, height: 24),
          activeIcon: Image.asset('/Users/risalat/Documents/flutter_application_134/web/ic_on_stores@3x.png', width: 24, height: 24),
          label: 'STORES',
        ),
        BottomNavigationBarItem(
           icon: Image.asset('/Users/risalat/Documents/flutter_application_134/web/ic_off_account@3x.png', width: 24, height: 24),
          activeIcon: Image.asset('/Users/risalat/Documents/flutter_application_134/web/ic_on_account@3x.png', width: 24, height: 24),
          label: 'ACCOUNT',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed, 
      onTap: _onItemTapped,
    ),
  );
}



}


class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Cart screen'),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Rewards screen'),
    );
  }
}

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Stores screen'),
    );
  }
}

class Page5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Account screen'),
    );
  }
}