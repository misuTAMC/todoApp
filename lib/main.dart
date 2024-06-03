import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinhtoandidong_project/app.dart';
import 'package:tinhtoandidong_project/firebase_options.dart';
import 'package:tinhtoandidong_project/provider/time_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider<TimeProvider>(
      create: (context) => TimeProvider(),
      child: const MyApp(),
    ),
  );
}
