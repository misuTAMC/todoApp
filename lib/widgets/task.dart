// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tinhtoandidong_project/model/note.dart';
import 'package:tinhtoandidong_project/resources/storage_method.dart';
import 'package:tinhtoandidong_project/screens/edit_note_screen.dart';

class TaskForm extends StatefulWidget {
  final Note _note; //final: giá trị cuối cùng

  const TaskForm(this._note,
      {super.key}); //Constructor của TaskForm nhận một tham số Note và có thể nhận một key tùy chọn.

  @override
  State<TaskForm> createState() =>
      _TaskFormState(); //Phương thức createState tạo ra trạng thái _TaskFormState để quản lý trạng thái của widget TaskForm.
} //=> mỗi khi TaskForm được tạo ra, nó sẽ được liên kết với một đối tượng Note cụ thể và trạng thái của nó sẽ được quản lý bởi _TaskFormState.

class _TaskFormState extends State<TaskForm>
    with SingleTickerProviderStateMixin {
  //SingleTickerProviderStateMixin là một mixin được sử dụng để cung cấp một Ticker cho AnimationController.
  //Ticker là một công cụ đồng bộ hóa khung hình với AnimationController.
  double opacityValue = 1.0;
  late AnimationController
      _controller; //late cho biết biến này được tạo sau khi lớp được tạo nhưng trước khi sử dụng.

  @override
  void initState() {
    //Ghi đè phương thức initState từ lớp State. Phương thức này được gọi một lần khi đối tượng trạng thái được khởi tạo.
    super
        .initState(); //Gọi phương thức initState của lớp cha để đảm bảo bất kỳ khởi tạo nào trong lớp cha cũng được thực hiện.
    _controller = AnimationController(
      duration:
          const Duration(seconds: 1), //Đặt thời lượng của animation là 1 giây.
      vsync:
          this, //Sử dụng this như là TickerProvider để đồng bộ hóa animation với khung hình.
    );
  }

  @override
  void dispose() {
    //Ghi đè phương thức dispose từ lớp State. Phương thức này được gọi khi đối tượng trạng thái bị hủy.
    _controller
        .dispose(); //Gọi phương thức dispose trên _controller để giải phóng tài nguyên được sử dụng bởi AnimationController.
    super
        .dispose(); //Gọi phương thức dispose của lớp cha để đảm bảo bất kỳ giải phóng tài nguyên nào trong lớp cha cũng được thực hiện.
  }

  Color getRandomColor() {
    return Color.fromARGB(
      255,
      200 + Random().nextInt(56),
      200 + Random().nextInt(56),
      200 + Random().nextInt(56),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDone = widget._note
        .isDone; //Gán giá trị của thuộc tính isDone từ _note (là một đối tượng Note được truyền vào TaskForm) cho biến isDone.
    int typeSave = widget._note
        .type; //Gán giá trị của thuộc tính type từ _note cho biến typeSave.
    return GestureDetector(
      onTap: () {
        widget._note.type == 100
            ? null //Kiểm tra nếu type của _note bằng 100, nếu đúng, không làm gì (null), nếu không, thực hiện điều hướng tới EditNote.
            : Navigator.push(
                //Điều hướng đến một màn hình mới.
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      EditNote(widget
                          ._note), //Định nghĩa trang đích là EditNote với _note được truyền vào.
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    //Định nghĩa cách chuyển đổi giữa các trang.
                    var begin = const Offset(1.0,
                        -1.0); //Điểm bắt đầu của animation (góc trên bên phải).
                    var end =
                        Offset.zero; //Điểm kết thúc của animation (vị trí gốc).
                    var curve =
                        Curves.ease; //Sử dụng đường cong easing cho animation.

                    var tween = Tween(begin: begin, end: end).chain(CurveTween(
                        curve:
                            curve)); //Tạo một tween để chuyển đổi từ begin đến end theo đường cong.

                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    ); //Sử dụng SlideTransition để di chuyển widget theo tween đã định nghĩa.
                  },
                  transitionDuration: const Duration(
                      seconds: 2), //Thời gian của chuyển đổi là 2 giây.
                ),
              );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Transform.rotate(
          angle: -0.05,
          child: Container(
            width: 220,

            margin: const EdgeInsets.only(bottom: 10), // Adjust margin here
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(
                  40), //Bo tròn các góc của Container bk 40 đv.
              color: getRandomColor(),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(-5, 0),
                ),
              ],
              image: DecorationImage(
                image:
                    AssetImage('assets/taskPicture/${widget._note.type}.png'),
                fit: BoxFit
                    .cover, //hình ảnh che phủ toàn bộ diện tích Container.
                opacity: 0.2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                // xếp chồng các widget con theo chiều dọc.
                crossAxisAlignment: CrossAxisAlignment
                    .start, //Căn chỉnh các widget con của Column theo cạnh trái.
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        //Widget này mở rộng Text để chiếm không gian còn lại trong Row.
                        child: Text(
                          '#${widget._note.title}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      widget._note.type == 100 //Nếu type của _note là 100
                          ? Row(
                              children: [
                                const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.auto_delete_outlined,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    //Hàm xử lý sự kiện khi nút được nhấn, gọi phương thức deleteTask từ StorageMethod để xóa task.
                                    StorageMethod().deleteTask(widget._note.id);
                                  },
                                ),
                              ],
                            )
                          : Checkbox(
                              //Nếu widget._note.type khác 100, hiển thị một ô checkbox
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    5), //Hình dạng của checkbox với góc bo tròn 5 đơn vị.
                              ),
                              side: const BorderSide(color: Colors.black),
                              checkColor: Colors.green,
                              activeColor: Colors
                                  .black, //Màu nền của checkbox khi được chọn là màu đen.
                              fillColor:
                                  MaterialStateProperty.all(Colors.white),
                              value:
                                  isDone, //Giá trị của checkbox, xác định trạng thái được chọn hay không.
                              onChanged: (value) {
                                //khi trạng thái của checkbox thay đổi.
                                setState(
                                  // Cập nhật trạng thái isDone, opacityValue, đổi type của _note dựa trên trạng thái của isDone.
                                  () {
                                    isDone = !isDone;
                                    opacityValue = isDone ? 0.0 : 1.0;
                                    if (isDone == true) {
                                      typeSave = widget._note.type;
                                      widget._note.type = 100;
                                    } else {
                                      widget._note.type = typeSave;
                                    }
                                  },
                                );
                                StorageMethod().isDoneTask(widget._note.id,
                                    isDone); //cập nhật trạng thái hoàn thành của task.
                                StorageMethod().updateTask(
                                    widget._note.id,
                                    widget._note.type,
                                    widget._note.title,
                                    widget._note
                                        .subTitle); //cập nhật task với các thuộc tính mới.
                              },
                            ),
                    ],
                  ),
                  const Divider(
                    // tạo đường kẻ ngăn cách
                    color: Colors.black,
                    thickness: 1,
                  ),
                  const SizedBox(
                      height:
                          10), //Tạo một khoảng trống có chiều cao 10 đơn vị để thêm không gian giữa các phần tử.
                  Text(
                    widget._note
                        .subTitle, //  Nội dung văn bản được lấy từ thuộc tính subTitle của Note.
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  // Expanded(
                  //   child: Image(
                  //     image: AssetImage(
                  //         'assets/taskPicture/${widget._note.type}.png'),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
