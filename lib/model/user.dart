import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String username;
  final String phone;
  final List task;
  final String photoUrl;
  User({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.phone,
    required this.task,
  });
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'uid': uid,
      'username': username,
      'phone': phone,
      'task': task,
      'photoUrl': photoUrl,
    };
  }

  static User fromSnap(DocumentSnapshot snapshot) {
    //*data return ve la 1 map<String,dynamic>
    var snapshotAssignment = snapshot.data() as Map<String, dynamic>;

    return User(
      email: snapshotAssignment['email'] as String? ?? '',
      uid: snapshotAssignment['uid'] as String? ?? '',
      username: snapshotAssignment['username'] as String? ?? '',
      phone: snapshotAssignment['phone'] as String? ?? '',
      task: snapshotAssignment['task'] as List? ?? [],
      photoUrl: snapshotAssignment['photoUrl'] as String? ?? '',
    );
  }
}
//*DocumentSnapshot la 1 class cua cloud_firestore,no chua data cua 1 document cu the tren firestore
//*data():tra ve data cua document do duoi dang map<String,dynamic>
//*id:tra ve id cua document do
//*reference:tra ve DocumentReference cua document do,
//*exits:tra ve true neu document do ton tai,nguoc lai tra ve false

//*DocumentReference la 1 class cua cloud_firestore,no chua thong tin ve 1 document cu the tren firestore
//*collection:tra ve 1 collectionReference cua collection do
//*CollectionReference la 1 class cua cloud_firestore,no chua thong tin ve 1 collection cu the tren firestore
//*snapshots:tra ve 1 stream<DocumentSnapshot> cua document do
//*Stream la 1 class cua dart:async,no chua 1 luong du lieu
//*DocumentSnapshot la 1 class cua cloud_firestore,no chua data cua 1 document cu the tren firestore
