import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
    Reference ref =
        _firebaseStorage.ref().child(_firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(file);
    //*cho upload task chay xong thi lay value cua no gan vao taskSnapshot
    TaskSnapshot taskSnapshot = await uploadTask;
    //*lay download url cua anh vua upload
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
