// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tinhtoandidong_project/screens/login_screen.dart';

import '../model/user.dart' as model;

// Định nghĩa một lớp tên là AuthMethods
class AuthMethods {
  // Tạo một instance của FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Tạo một instance của FirebaseFirestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Phương thức đăng ký người dùng, yêu cầu 4 tham số: email, password, username, và phone
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String phone,
  }) async {
    // Khởi tạo một biến res1 để lưu trữ kết quả, chủ yếu để kiểm tra lỗi trong debug console
    String res1 = "Some error occured in dang ky :loi o auth_method.dart";

    try {
      // Kiểm tra xem các tham số có rỗng không
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          phone.isNotEmpty) {
        // Đăng ký người dùng với email và password
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email.trim(), // Loại bỏ khoảng trắng ở đầu và cuối
          password: password.trim(), // Loại bỏ khoảng trắng ở đầu và cuối
        );
        // In uid của người dùng ra console
        print(userCredential.user!.uid);
        // Tạo một đối tượng người dùng theo model đã tạo (ở model/user.dart)
        model.User user = model.User(
          email: email,
          uid: userCredential.user!.uid,
          username: username,
          phone: phone,
        );
        // Thêm người dùng vào firestore
        await _firestore
            .collection('users') // Tạo một collection tên là 'users'
            .doc(userCredential.user!.uid) // Tạo một document với id là uid của người dùng
            .set(user.toJson()); // Đặt dữ liệu cho document này là dữ liệu của người dùng
        res1 = "Success dang ki:o auth_method.dart";
      }
    } on FirebaseAuthException catch (e) {
      // Xử lý các lỗi có thể xảy ra khi đăng ký
      if (e.code == 'invalid-email') {
        return 'The email address is not valid.';
      } else if (e.code == 'email-already-in-use') {
        return 'The email address is already in use by another account.';
      } else {
        return e.toString(); // or just 'An error occurred.'
      }
    } catch (err) {
      res1 = err.toString();
    }
    return res1;
  }

  // Phương thức đăng nhập người dùng, yêu cầu 2 tham số: email và password
  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    String res2 = "Some error occuredin dang nhap:loi o auth_method.dart";
    try {
      // Kiểm tra xem email và password có rỗng không
      if (email.isNotEmpty || password.isNotEmpty) {
        // Đăng nhập người dùng với email và password
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        // In uid của người dùng ra console
        print(userCredential.user!.uid);
        res2 = "Success dang nhap:o auth_method.dart";
      } else {
        res2 = "Email or password is empty";
      }
    } on FirebaseAuthException catch (e) {
      // Xử lý các lỗi có thể xảy ra khi đăng nhập
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.toString();
      }
    } catch (err) {
      res2 = err.toString();
    }
    return res2;
  }

  // Phương thức lấy thông tin chi tiết của người dùng hiện tại
  Future<model.User> getUserDetails() async {
    // Lấy người dùng hiện tại
    User currentUser = _auth.currentUser!;
    // Lấy thông tin của người dùng từ firestore
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();
    // Trả về một đối tượng User từ snapshot
    return model.User.fromSnap(documentSnapshot);
  }

  // Phương thức đăng xuất người dùng
  Future<void> signOut(BuildContext context) async {
    // Đăng xuất người dùng
    await _auth.signOut();
    // Điều hướng người dùng về màn hình đăng nhập
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
  }
  Future<void> resetPasswordWithLink(String email) async {
   try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }
}