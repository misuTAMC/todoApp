import 'package:flutter/material.dart';
import 'package:tinhtoandidong_project/model/note.dart';
import 'package:tinhtoandidong_project/resources/storage_method.dart';

//https://drive.google.com/drive/folders/1DpJeQ97lwyMo4VxTzYNUEqr16L-X9Gdz?fbclid=IwZXh0bgNhZW0CMTAAAR1xmorck_jAF-peNLS8oU5exdEgIsLlRblBuJIWbckZtkRpBVRcuUaC6S4_aem_ATQlz_nzihR2RCuwAwHyAuYtvl963za-t-EOIbwawI7W1S_npKWroi1Ghj2qGhFocwEzL1WCb7AiV6zy-xWYMgwl
class EditNote extends StatefulWidget {
  //EditNote.
  final Note _note;
  const EditNote(this._note,
      {super.key}); //hàm khởi tạo (constructor) của lớp EditNote
  @override
  State<EditNote> createState() =>
      _EditNoteState(); //tạo ra trạng thái (state) của widget EditNote.
}

class _EditNoteState extends State<EditNote> {
  //lớp con
  TextEditingController?
      title; // lưu trữ một đối tượng TextEditingController hoặc null.
  TextEditingController? subTitle;

  final FocusNode _focusNode1 =
      FocusNode(); //theo dõi trạng thái focus của trường nhập liệu
  final FocusNode _focusNode2 = FocusNode();
  int indexx = 0;
  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget._note.title);
    subTitle = TextEditingController(text: widget._note.subTitle);
  } //chỉnh sửa ghi chú, đảm bảo rằng các trường văn bản được điền trước với nội dung ghi chú hiện có.

  @override
  Widget build(BuildContext context) {
    //khai báo phương thức build trả về một widget.
    return Scaffold(
      //Widget chính để xây dựng cấu trúc cơ bản của màn hình.
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          //Sắp xếp các widget theo chiều dọc.
          mainAxisAlignment: MainAxisAlignment
              .center, // phân bố các widget con dọc theo trục chính
          children: [
            titleWidgets(), //widget để nhập tiêu đề ghi chú.
            const SizedBox(height: 20),
            subtiteWedgite(), //widget để nhập phần phụ đề ghi chú
            const SizedBox(height: 20),
            imagess(), //giao diện chọn ảnh đại diện cho ghi chú
            const SizedBox(height: 20),
            button()
          ],
        ),
      ),
    );
  }

  Widget button() {
    //khai báo phương thức button trả về một widget.
    return Row(
      //sắp xếp các widget con theo hàng ngang.
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.grey,
            side: const BorderSide(color: Colors.black),
            backgroundColor: Colors.white,
            minimumSize: const Size(170, 48),
          ),
          onPressed: () {
            //Hàm xử lý khi người dùng click vào nút bấm
            StorageMethod().updateTask(
                //Gọi phương thức updateTask từ lớp StorageMethod để cập nhật ghi chú.
                widget._note.id,
                indexx,
                title!.text,
                subTitle!.text);
            Navigator.pop(
                context); //đóng màn hình chỉnh sửa ghi chú mà không thực hiện cập nhật.
          },
          child: const Text(
            //định dạng text
            'Done',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
        ElevatedButton(
          //
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.grey,
            side: const BorderSide(color: Colors.black),
            backgroundColor: Colors.white,
            minimumSize: const Size(170, 48),
          ),
          onPressed: () {
            //thao tác người dùng click vào nút bấm
            Navigator.pop(
                context); //Navigator.pop(context); : Chỉ đóng màn hình chỉnh sửa ghi chú mà không cập nhật bất kỳ thay đổi nào.
          },
          child: const Text(
            'Cancel', //huy
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
    //anh ghi chu
    return SizedBox(
      height: 180,
      child: ListView.builder(
        itemCount: 4, //4 anh toi da
        scrollDirection:
            Axis.horizontal, //Thiết lập cuộn danh sách theo chiều ngang
        itemBuilder: (context, index) {
          //Hàm này được gọi để xây dựng từng mục (item) trong danh sách.
          return GestureDetector(
            //Biến mục danh sách thành một widget nhận diện cử chỉ (click).
            onTap: () {
              //thực thi khi người dùng chạm và nhả tay trên mục
              setState(() {
                //Cập nhật giá trị của biến indexx bằng với chỉ số index của mục được chọn.
                indexx = index;
              });
            },
            child: Padding(
              //Thêm khoảng đệm cho nội dung bên trong mục
              padding: EdgeInsets.only(left: index == 0 ? 7 : 0),
              child: Container(
                //Khung chứa chính cho nội dung của mỗi mục
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: indexx == index
                        ? Colors.black
                        : Colors
                            .grey, //Nếu indexx bằng với index của mục hiện tại (được chọn), viền sẽ có màu đen.
                    //Ngược lại, viền sẽ có màu xám
                  ),
                ),
                width: 140,
                margin: const EdgeInsets.all(
                    8), //Khoảng cách ngoài (margin) xung quanh container
                child: Column(
                  //Sắp xếp các widget con theo chiều dọc bên trong container
                  children: [
                    Container(
                      //Khung chứa cho ảnh
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        //hiển thị ảnh
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/taskPicture/$index.png'), //Đường dẫn đến ảnh.
                          fit: BoxFit
                              .cover, //Thiết lập ảnh phủ kín toàn bộ container, có thể bị cắt xén nếu tỷ lệ ảnh không khớp với container.
                        ),
                      ),
                    ),
                    const SizedBox(
                        height:
                            10), //Thêm khoảng trống 10 pixel phía dưới ảnh đại diện
                    Text(
                      //Widget hiển thị văn bản
                      index == 0
                          ? '#Study '
                          : index == 1
                              ? '#Healthy  '
                              : index == 2
                                  ? '#Work'
                                  : '#Other ',
                      //Nếu index là 0, hiển thị "#Study ".
                      // Tương tự với các điều kiện index == 1, index == 2, và index == 3 hiển thị các tiêu đề "#Healthy ", "#Work", và "#Other "
                      style: TextStyle(
                        //Kiểu chữ hiển thị
                        color: indexx == index ? Colors.black : Colors.grey,
                        //Nếu indexx bằng với index của mục hiện tại (được chọn), văn bản sẽ có màu đen.
                        // Ngược lại, văn bản sẽ có màu xám.
                        fontSize: 18,
                        fontWeight: FontWeight.w500, //Độ đậm của font chữ
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
    //khai báo phương thức titleWidgets trả về một widget.
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal:
              15), //Thêm khoảng đệm (padding) 15 pixel đối xứng cho nội dung bên trong (đệm ngang).
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          //Widget chính để người dùng nhập tiêu đề ghi chú
          controller:
              title, //người dùng nhập vào sẽ được lưu trữ trong biến title
          focusNode: _focusNode1,
          style: const TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              hintText:
                  'What do you want to do today?', //Văn bản gợi ý xuất hiện khi TextField trống
              hintStyle: const TextStyle(
                  color: Colors.grey), //Kiểu chữ của văn bản gợi ý.
              enabledBorder: OutlineInputBorder(
                //Khung viền khi TextField không được focus
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                //Khung viền khi TextField đang được focus
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          maxLines: 3, //Cho phép người dùng nhập văn bản tối đa 3 dòng
          controller: subTitle, //Liên kết TextField với biến subTitle
          focusNode: _focusNode2,
          style: const TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText:
                'Can I know more about it?', //Văn bản gợi ý xuất hiện bên trong TextField khi người dùng chưa nhập gì.
            hintStyle: const TextStyle(
                color: Colors
                    .grey), //Thiết lập kiểu chữ cho văn bản gợi ý. Màu sắc được thiết lập là màu xám
            enabledBorder: OutlineInputBorder(
              //Khung viền mặc định của TextField khi không được focus.
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
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
