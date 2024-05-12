import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinhtoandidong_project/model/user.dart' as model;
import 'package:tinhtoandidong_project/provider/user_provider.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Center(
        child: Text(
          user.username,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.purple,
          ),
        ),
      ),
    );
  }
}
