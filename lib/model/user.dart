import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String username;
  final String phone;
  
  
  User({
    required this.email,
    required this.uid,
    
    required this.username,
    required this.phone,
    
  });
  //*tao 1 map<String,dynamic> de chuyen doi tu 1 object sang 1 map
  //*toJson():tra ve 1 map<String,dynamic> chua data cua object
  //*vi trong firebase thi data cua 1 document phai la 1 map<String,dynamic>
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'uid': uid,
      'username': username,
      'phone': phone,
      
      
    };
  }
  //*phương thức fromSnap được sử dụng để tạo một đối tượng `User` từ một `DocumentSnapshot`(1 bản ghi trong firestore)
  //*nó lấy dữ liệu từ `snapshot` và ép kiểu nó thành `Map<String, dynamic>`
  //*và sau đó sử dụng dữ liệu đó để tạo một đối tượng `User`.nêu giá trị không tồn tại thì sẽ return ''
 // Định nghĩa một phương thức tĩnh `fromSnap` nhận vào một `DocumentSnapshot`
static User fromSnap(DocumentSnapshot snapshot) {
    // Lấy dữ liệu từ `snapshot` và ép kiểu nó thành `Map<String, dynamic>`
    var snapshotAssignment = snapshot.data() as Map<String, dynamic>;

    // Trả về một đối tượng `User` mới được tạo từ dữ liệu trong `snapshot`
    return User(
      // Lấy giá trị 'email' từ `snapshot`, ép kiểu nó thành `String`
      // Nếu giá trị 'email' không tồn tại, sử dụng chuỗi rỗng ('') thay thế
      email: snapshotAssignment['email'] as String? ?? '',
      // Lấy giá trị 'uid' từ `snapshot`, ép kiểu nó thành `String`
      // Nếu giá trị 'uid' không tồn tại, sử dụng chuỗi rỗng ('') thay thế
      uid: snapshotAssignment['uid'] as String? ?? '',
      // Lấy giá trị 'username' từ `snapshot`, ép kiểu nó thành `String`
      // Nếu giá trị 'username' không tồn tại, sử dụng chuỗi rỗng ('') thay thế
      username: snapshotAssignment['username'] as String? ?? '',
      // Lấy giá trị 'phone' từ `snapshot`, ép kiểu nó thành `String`
      // Nếu giá trị 'phone' không tồn tại, sử dụng chuỗi rỗng ('') thay thế
      phone: snapshotAssignment['phone'] as String? ?? '',
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
