import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tinhtoandidong_project/model/note.dart';
import 'package:uuid/uuid.dart';

// Định nghĩa một lớp tên là StorageMethod
class StorageMethod {
  // Tạo một instance của FirebaseStorage
  // final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  // Tạo một instance của FirebaseAuth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // // Phương thức upload ảnh lên Firebase Storage
  // Future<String> uploadImageToStorage(
  //     String childName, Uint8List file, bool isPost) async {
  //   // Kiểm tra xem có người dùng hiện tại không
  //   if (_firebaseAuth.currentUser == null) {
  //     print('No current user');
  //     return 'Error';
  //   }
  //   // Tạo một tham chiếu đến Firebase Storage dựa trên uid của người dùng hiện tại
  //   Reference ref =
  //       _firebaseStorage.ref().child(_firebaseAuth.currentUser!.uid);

  //   // Tạo một tác vụ upload
  //   UploadTask uploadTask = ref.putData(file);
  //   // Chờ tác vụ upload hoàn thành và lấy kết quả
  //   TaskSnapshot taskSnapshot = await uploadTask;
  //   // Lấy url download của ảnh vừa upload
  //   String downloadUrl = await taskSnapshot.ref.getDownloadURL();
  //   return downloadUrl;
  // }

  //todo: Tạo một instance của FirebaseFirestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Phương thức thêm task vào Firestore
  Future<bool> addTask(String subTitle, String title, int type) async {
    try {
      // Tạo một id duy nhất cho task
      var uuid = const Uuid().v4();
      // Thêm task vào Firestore
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
        'time': DateTime.now(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  //todo: Phương thức lấy danh sách task từ Firestore
  //* Tham số snapshot là một AsyncSnapshot:chứa data từ các async activity
  //*trong trường hợp này là snapshot từ firestore
  List getTask(AsyncSnapshot snapshot) {
    try {
      //*khởi tạo 1 tastList
      //*nó lấy docs từ snapshot.data và map : biến đổi mỗi mục trong danh sách và trả về một danh sách mới
      final tasksList = snapshot.data.docs.map((DocumentSnapshot doc) {
        //*lấy data từ mỗi tai liệu Firestore(doc) và chuyển nó thành một Map<String, dynamic> vì nó ko doc.data() trả về 1 object
        //*nên cần ép kiểu nó thành Map<String, dynamic>
        final data = doc.data() as Map<String, dynamic>;
        //*trả về một Note mới(created note mới từ data)
        return Note(
          data['id'],
          data['subTitle'],
          data['time'].toDate().toString(),
          data['type'],
          data['title'],
          data['isDone'],
        );
        //*chuyển danh sách các Note thành danh sách
      }).toList();
      //*trả về danh sách các object Note be created from Firestore
      return tasksList;
    } catch (e) {
      print('Error fetching tasks: $e');
      return [];
    }
  }

  //todo: Phương thức lấy stream của danh sách task từ Firestore
  Stream<QuerySnapshot> streamTask() {
    return _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('tasks')
        //*snapshot():lấy 1 stream của querySnapshot mục đích là để lắng nghe sự thay đổi của dữ liệu(liên quan tới CRUD:thêm, sửa, xóa)
        //*nên cần lắng nghe sự thay đổi của dữ liệu
        .snapshots();
  }

  //todo: Phương thức cập nhật trạng thái của task
  //*nếu done thì trả về true, ngược lại trả về false
  //*nếu isDone=true sẽ drop task xuống Done(mục đích)
  Future<bool> isDoneTask(String id, bool isDone) async {
    try {
      await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('tasks')
          .doc(id)
          .update({
        'isDone': isDone,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  //todo:Phương thức cập nhật thông tin của task
  Future<bool> updateTask(
      String id, int type, String title, String subTitle) async {
    try {
      await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('tasks')
          .doc(id)
          .update({
        'type': type,
        'title': title,
        'subTitle': subTitle,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  //todo:Phương thức xóa task
  Future<bool> deleteTask(String id) async {
    try {
      await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('tasks')
          .doc(id)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  // Phương thức lấy tên người dùng từ Firestore
  Future<String> getUserName() async {
    try {
      final user = await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .get();
      return user.data()!['username'];
    } catch (e) {
      return 'User';
    }
  }
}
