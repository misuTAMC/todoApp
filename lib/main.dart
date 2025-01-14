
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
    //* Sử dụng ChangeNotifierProvider để cung cấp TimeProvider cho toàn bộ ứng dụng
    //? ChangeNotifierProvider cung cấp một đối tượng TimeProvider cho toàn bộ ứng dụng
    //*:nó sẽ tạo ra một instance TimeProvider mới và cung cấp nó cho widget con 
    //*khi timeProvider thay đổi(được gọi hàm notifyListeners()), tất cả các widget con sẽ được rebuild(được gọi hàm build())
    
    ChangeNotifierProvider<TimeProvider>(
      create: (context) => TimeProvider(),
      child: const MyApp(),
    ),
  );
}
