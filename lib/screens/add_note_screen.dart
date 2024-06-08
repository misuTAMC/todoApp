import 'package:flutter/material.dart';
import 'package:tinhtoandidong_project/resources/storage_method.dart';

//https://drive.google.com/drive/folders/1DpJeQ97lwyMo4VxTzYNUEqr16L-X9Gdz?fbclid=IwZXh0bgNhZW0CMTAAAR1xmorck_jAF-peNLS8oU5exdEgIsLlRblBuJIWbckZtkRpBVRcuUaC6S4_aem_ATQlz_nzihR2RCuwAwHyAuYtvl963za-t-EOIbwawI7W1S_npKWroi1Ghj2qGhFocwEzL1WCb7AiV6zy-xWYMgwl
class AddNote extends StatefulWidget {
  const AddNote(
      {super.key}); // khóa quản lý các widget trong giao diện người dùng.
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  //Dòng này khai báo một lớp riêng tư tên là _AddNoteState kế thừa từ lớp State<AddNote>
  final title = TextEditingController(); //nhap noi dung
  //final: giá trị không thể thay đổi sau khi được khởi tạo.
  final subtitle = TextEditingController(); // phụ đề (subtitle)

  final FocusNode _focusNode1 =
      FocusNode(); //Focus cho biết TextField nào đang được người dùng nhập liệu.
  final FocusNode _focusNode2 = FocusNode();
  int indexx = 0; //kiểu int và khởi tạo giá trị bằng 0.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //giàn giáo
      backgroundColor: Colors.white, //Cài đặt màu nền của màn hình
      body: SafeArea(
        //nội dung widget con tránh khỏi các notch hoặc camera cutout trên một số thiết bị.
        child: Column(
          //tạo một widget Column xếp widget con theo chiều dọc
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            titleWidgets(), //nhập tiêu đề.
            const SizedBox(height: 20),
            subtiteWedgite(), //widget liên quan đến phần phụ đề của ghi chú
            const SizedBox(height: 20),
            imagess(),
            const SizedBox(height: 20),
            button() //nhấn lưu ghi chú
          ],
        ),
      ),
    );
  }

  Widget button() {
    //nút
    return Row(
      mainAxisAlignment: MainAxisAlignment
          .spaceAround, //sắp xếp các widget dọc theo một trục duy nhất
      children: [
        ElevatedButton(
          //nút thêm có hiệu ứng nhấp nhô
          style: ElevatedButton.styleFrom(
            //tùy chỉnh kiểu dáng của nút Thêm
            shadowColor: Colors.grey, //đổ bóng
            side: const BorderSide(color: Colors.black),
            backgroundColor: Colors.white,
            minimumSize: const Size(170, 48),
          ),
          onPressed: () {
            //thiết lập hành vi khi nút thêm được nhấn
            StorageMethod().addTask(subtitle.text, title.text,
                indexx); //gọi đến phương thức addTask từ một lớp có tên StorageMethod.
            Navigator.pop(
                context); //đóng màn hình AddNote và quay lại màn hình trước
          },
          child: const Text(
            //đặt nội dung (văn bản) hiển thị trên nút thêm
            'Add', //dạng thêm
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.grey,
            side: const BorderSide(color: Colors.black),
            backgroundColor: Colors.white,
            minimumSize: const Size(170, 48),
          ),
          onPressed: () {
            Navigator.pop(
                context); //dùng để đóng (pop) màn hình thêm ghi chú và quay lại màn hình trước đó
          },
          child: const Text(
            'Cancel', // dạng hủy
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  SizedBox imagess() {
    //ghi chú bằng ảnh
    return SizedBox(
      height: 180,
      child: ListView.builder(
        //danh sách cuộn ngang phù hợp với hiển thị màn hình
        itemCount: 4,
        scrollDirection: Axis.horizontal, //cuộn ngang
        itemBuilder: (context, index) {
          //mục danh sách.
          return GestureDetector(
            //Cho phép tương tác (bấm) vào mục để chọn ảnh.
            onTap: () {
              //chạm và nhả tay trên mục.
              setState(() {
                //cập nhật trạng thái của widget AddNote
                indexx = index;
              });
            },
            child: Padding(
              //Thêm khoảng đệm cho nội dung bên trong.
              padding: EdgeInsets.only(left: index == 0 ? 7 : 0), //đệm trái
              child: Container(
                //Khung chứa chính cho nội dung của mỗi mục.
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2, //
                    color: indexx == index ? Colors.black : Colors.grey,
                  ),
                ),
                width: 140,
                margin: const EdgeInsets.all(
                    8), //Khoảng cách ngoài (margin) xung quanh container
                child: Column(
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/taskPicture/$index.png'), //sử dụng AssetImage để truy cập ảnh từ thư mục assets/taskPicture/ với tên index.png
                          fit: BoxFit
                              .cover, //khớp nối ảnh lấp toàn bộ container.
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      index == 0
                          ? '#Study '
                          : index == 1
                              ? '#Healthy  '
                              : index == 2
                                  ? '#Work'
                                  : '#Other ',
                      style: TextStyle(
                        color: indexx == index
                            ? Colors.black
                            : Colors.grey, //index 0 1 2 black # grey
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget titleWidgets() {
    //hiển thị tiêu đề đúng định dạng
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 15), //thêm khoảng cách xung quanh nội dung của một widget
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          //Widget chính để người dùng nhập tiêu đề ghi chú.
          controller: title,
          focusNode: _focusNode1,
          style: const TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
              //Thuộc tính dùng để tùy chỉnh giao diện của TextField
              contentPadding: //Khoảng trống giữa nội dung văn bản và khung viền.
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              hintText:
                  'What do you want to do today?', //Văn bản gợi ý xuất hiện khi TextField trống
              hintStyle: const TextStyle(
                  color: Colors.grey), //Kiểu chữ của văn bản gợi ý.
              enabledBorder: OutlineInputBorder(
                //Khung viền khi TextField không được focus.
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                //Khung viền khi TextField đang được focus (được người dùng nhập liệu).
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
              )),
        ),
      ),
    );
  }

  Padding subtiteWedgite() {
    //khai báo phương thức subtiteWedgite trả về một widget kiểu Padding
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          maxLines: 3, //nhập tối đa 3 dòng văn bản
          controller:
              subtitle, //văn bản nhập vào được lưu trữ trong biến subtitle
          focusNode: _focusNode2,
          style: const TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
            //Thuộc tính này dùng để tùy chỉnh giao diện của TextField
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText:
                'Can I know more about it?', //Văn bản gợi ý xuất hiện khi TextField trống.
            hintStyle: const TextStyle(
                color: Colors.grey), //Kiểu chữ của văn bản gợi ý.
            enabledBorder: OutlineInputBorder(
              //Khung viền khi TextField không được focus.
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              //Khung viền khi TextField đang được focus (được người dùng nhập liệu).
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
