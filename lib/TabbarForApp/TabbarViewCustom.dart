import 'package:flutter/material.dart';
import 'package:flutter_application_134/HomeView/View/HomeScreen.dart';
import 'package:flutter_application_134/TabbarForApp/ProfileScreen.dart';

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
    ProfileScreen(),
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
          icon: Image.asset('images/menuoff.png', width: 24, height: 24),
          activeIcon: Image.asset('images/menuon.png', width: 24, height: 24),
          label: 'HOME',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('images/cartoff.png', width: 24, height: 24),
          activeIcon: Image.asset('images/carton.png', width: 24, height: 24),
          label: 'CART',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('images/rewardoff.png', width: 24, height: 24),
          activeIcon: Image.asset('images/rewardon.png', width: 24, height: 24),
          label: 'REWARDS',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('images/storeoff.png', width: 24, height: 24),
          activeIcon: Image.asset('images/storeon.png', width: 24, height: 24),
          label: 'STORES',
        ),
        BottomNavigationBarItem(
           icon: Image.asset('images/accountoff.png', width: 24, height: 24),
          activeIcon: Image.asset('images/accounton.png', width: 24, height: 24),
          label: 'Profile',
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
