import 'package:flutter/material.dart';
import 'package:tinhtoandidong_project/screens/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'tinh toan di dong',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.red.shade100,
      ),
      // home: const ResponsiveLayout(
      //   webScreenLayout: WebScreenLayout(),
      //   mobileScreenLayout: MobileScreenLayout(),
      // ),
      home: const LoginScreen(),
    );
  }
}
