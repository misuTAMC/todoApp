// ignore_for_file: avoid_print
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:tinhtoandidong_project/resources/storage_method.dart';

import '../model/user.dart' as model;

class AuthMethods {
  //*tao 1 instance cua FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //*sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String phone,
    required Uint8List file,
  }) async {
    String res1 = "Some error occured in dang ky :loi o auth_method.dart";

    String photoUrl =
        await StorageMethod().uploadImageToStorage('avatar', file, false);
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          phone.isNotEmpty) {
        //*register user with email and password
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );
        print(userCredential.user!.uid);
        //*create user object theo model duoc tao(o model/user.dart)
        model.User user = model.User(
          email: email,
          uid: userCredential.user!.uid,
          username: username,
          phone: phone,
          task: [],
          photoUrl: photoUrl,
        );
        //*add user to firestore
        await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(user.toJson());
        res1 = "Success dang ki:o auth_method.dart";
      }
    } on FirebaseAuthException catch (e) {
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

  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    String res2 = "Some error occuredin dang nhap:loi o auth_method.dart";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        print(userCredential.user!.uid);
        res2 = "Success dang nhap:o auth_method.dart";
      } else {
        res2 = "Email or password is empty";
      }
    } on FirebaseAuthException catch (e) {
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

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(documentSnapshot);
  }
}
