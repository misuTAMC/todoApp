import 'package:flutter/material.dart';
import 'package:tinhtoandidong_project/screens/pomodoro_screen.dart';
import 'package:tinhtoandidong_project/screens/todo_screen.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _pageIndex = 0;
  static const List<Widget> _screenOption = <Widget>[
    TodoScreen(),
    Text(
      'Index 2: Favorite Screen',
      style: TextStyle(fontSize: 24, color: Colors.red),
    ),
    PomodoroScreen(),
  ];

  void navigationTapped(int indexOfPage) {
    setState(() {
      _pageIndex = indexOfPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    //model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: Center(
        child: _screenOption.elementAt(_pageIndex),
      ),
    );
  }
}


