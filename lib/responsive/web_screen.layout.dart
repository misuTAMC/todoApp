import 'package:flutter/material.dart';

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Web Screen Layout',
          style: TextStyle(
            fontSize: 24,
            color: Colors.purple,
          ),
        ),
      ),
    );
  }
}
