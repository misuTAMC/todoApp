import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tinhtoandidong_project/model/note.dart';
import 'package:uuid/uuid.dart';

class StorageMethod {
  //*tao 2 instance cua 2 dua nay de tuong tac voi firebase storage va firebase auth
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //todo:adding image to firebase storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    //*tao 1 tham chieu den firebase storage dua tren uid cua moi user
    //*ref(): lay tham chieu den root(goc re) cua firebase storage
    //*nhu viec open door de co the truy cap vao storage space cua firebase
    //*child():cho phep di sau hone vao cay thu muc cua firebase storage
    if (_firebaseAuth.currentUser == null) {
      print('No current user');
      return 'Error';
    }
    Reference ref =
        _firebaseStorage.ref().child(_firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(file);
    //*cho upload task chay xong thi lay value cua no gan vao taskSnapshot
    TaskSnapshot taskSnapshot = await uploadTask;
    //*lay download url cua anh vua upload
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //todo:add task to firebase storage
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<bool> addTask(String subTitle, String title, int type) async {
    try {
      DateTime dateTime = DateTime.now();
      var uuid = const Uuid().v4();
      await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('tasks')
          .doc(uuid)
          .set({
        'id': uuid,
        'isDone': false,
        'title': title,
        'subTitle': subTitle,
        'type': type,
        'time': dateTime,
      });
      return true;
    } catch (e) {
      return true;
    }
  }

  List getTask(AsyncSnapshot snapshot) {
    try {
      final tasksList = snapshot.data.docs.map((DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Note(
          data['id'],
          data['subTitle'],
          data['time'].toDate().toString(),
          data['type'],
          data['title'],
          data['isDone'],
        );
      }).toList();
      return tasksList;
    } catch (e) {
      print('Error fetching tasks: $e');
      return [];
    }
  }

  Stream<QuerySnapshot> streamTask() {
    return _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('tasks')
        .snapshots();
  }
}
