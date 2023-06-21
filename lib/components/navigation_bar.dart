import 'package:fashion_flow/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:fashion_flow/screens/home_screen.dart';
import 'package:fashion_flow/screens/explore_screen.dart';
import 'package:fashion_flow/screens/camera.dart';
import 'package:fashion_flow/screens/notification_screen.dart';
import 'package:fashion_flow/screens/profile_screen.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ExploreScreen(),
    Camera(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        color: Colors.white,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                iconSize: 30.0,
                padding: const EdgeInsets.only(left: 28.0),
                icon: Icon(Icons.home, color: _selectedIndex == 0 ? ffColors.Purple : ffColors.Pink),
                onPressed: () => _onItemTapped(0),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              IconButton(
                iconSize: 30.0,
                padding: const EdgeInsets.only(right: 28.0),
                icon: Icon(Icons.search, color: _selectedIndex == 1 ? ffColors.Purple : ffColors.Pink),
                onPressed: () => _onItemTapped(1),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              IconButton(
                iconSize: 30.0,
                padding: const EdgeInsets.only(left: 28.0),
                icon: Icon(Icons.notifications, color: _selectedIndex == 3 ? ffColors.Purple : ffColors.Pink),
                onPressed: () => _onItemTapped(3),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              IconButton(
                iconSize: 30.0,
                padding: const EdgeInsets.only(right: 28.0),
                icon: Icon(Icons.person, color: _selectedIndex == 4 ? ffColors.Purple : ffColors.Pink),
                onPressed: () => _onItemTapped(4),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onItemTapped(2),
        tooltip: 'Camera',
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: ffColors.Pink),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
