import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:tinhtoandidong_project/model/user.dart' as model;
import 'package:tinhtoandidong_project/provider/user_provider.dart';

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
    model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: Center(
        child: _screenOption.elementAt(_pageIndex),
      ),
      bottomNavigationBar: GNav(
        tabs: [
          GButton(
            icon: Icons.format_list_bulleted_add,
            gap: 8,
            backgroundGradient: LinearGradient(
                colors: [Colors.blue.shade50, Colors.pink.shade50]),
            text: 'Todo',
            textColor: Colors.black,
            backgroundColor: Colors.red.shade200,
            iconColor: Colors.black,
            iconActiveColor: Colors.pinkAccent,
          ),
          GButton(
            icon: Icons.favorite_border_outlined,
            gap: 8,
            text: 'Favorite',
            textColor: Colors.black,
            backgroundColor: Colors.red.shade200,
            backgroundGradient: LinearGradient(
                colors: [Colors.blue.shade50, Colors.pink.shade50]),
            iconColor: Colors.black,
            iconActiveColor: Colors.pink.shade50,
          ),
          GButton(
            icon: Icons.hourglass_empty_rounded,
            gap: 8,
            text: 'Timer',
            textColor: Colors.black,
            backgroundColor: Colors.red.shade200,
            backgroundGradient: LinearGradient(
                colors: [Colors.blue.shade50, Colors.pink.shade50]),
            iconColor: Colors.black,
            iconActiveColor: Colors.pinkAccent,
          ),
        ],
        backgroundColor: Colors.pink.shade50,
        selectedIndex: _pageIndex,
        onTabChange: (index) => navigationTapped(index),

        //gap: 20,
        // curve: Curves.linear,
      ),
    );
  }
}

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      body: const Center(
        child: Text('Todo Screen',
            style: TextStyle(fontSize: 24, color: Colors.black)),
      ),
    );
  }
}

class PomodoroScreen extends StatelessWidget {
  const PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      body: const Center(
        child: Text(
          'Pomodoro Screen',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
