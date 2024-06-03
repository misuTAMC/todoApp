import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinhtoandidong_project/provider/user_provider.dart';
import 'package:tinhtoandidong_project/responsive/mobile_screen_layout.dart';
import 'package:tinhtoandidong_project/responsive/responsive_layout_screen.dart';
import 'package:tinhtoandidong_project/responsive/web_screen.layout.dart';
import 'package:tinhtoandidong_project/screens/banner_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    notificationHandler();
    super.initState();
  }

  void notificationHandler() {
    FirebaseMessaging.onMessage.listen((event) async {
      print(event.notification!.body);
     
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'tinh toan di dong',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.purple.shade50,
        ),
        home: StreamBuilder(
          //todo: when the user signs in or out, the authStateChanges stream will emit an event
          stream: FirebaseAuth.instance.authStateChanges(),
          //todo: the builder will be called with the latest event from the stream
          builder: (context, snapshot) {
            //*kiem tra coi cai stream co hoat dong hay khong va co the gui event duoc khong
            if (snapshot.connectionState == ConnectionState.active) {
              //*kiem tra xem co data hay khong
              if (snapshot.hasData) {
              
                return const ResponsiveLayout(
                  webScreenLayout: WebScreenLayout(),
                  mobileScreenLayout: MobileScreenLayout(),
                );
                //*bat loi
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                  ),
                );
              }
              //*wait du lieu
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            //*default
            return const BannerScreen();
          },
        ),
      ),
    );
  }
}
