import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:myapp/nav_bar_items/cal_page.dart';
import 'package:myapp/nav_bar_items/home_page.dart';
import 'package:myapp/nav_bar_items/list_pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  List screens = [const ListPage(), const HomePage(), const CalcPage()];

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: screens[_currentIndex],
      bottomNavigationBar: GNav(
        onTabChange: onTap,
        selectedIndex: _currentIndex,
        tabs: const [
          GButton(
            icon: Icons.align_horizontal_left_rounded,
            text: 'List',
            iconActiveColor: Colors.black,
            textColor: Colors.black,
          ),
          GButton(
            icon: Icons.home,
            text: 'Home',
            iconActiveColor: Colors.black,
            textColor: Colors.black,
          ),
          GButton(
            icon: Icons.align_vertical_bottom_rounded,
            text: 'Graphics',
            iconActiveColor: Colors.black,
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
