import 'package:flutter/material.dart';
import 'package:tinhtoandidong_project/model/note.dart';
import 'package:tinhtoandidong_project/resources/storage_method.dart';

//https://drive.google.com/drive/folders/1DpJeQ97lwyMo4VxTzYNUEqr16L-X9Gdz?fbclid=IwZXh0bgNhZW0CMTAAAR1xmorck_jAF-peNLS8oU5exdEgIsLlRblBuJIWbckZtkRpBVRcuUaC6S4_aem_ATQlz_nzihR2RCuwAwHyAuYtvl963za-t-EOIbwawI7W1S_npKWroi1Ghj2qGhFocwEzL1WCb7AiV6zy-xWYMgwl
class EditNote extends StatefulWidget { //khai báo một lớp con của StatefulWidget có tên EditNote.
  // Lớp con này được sử dụng để xây dựng các widget có trạng thái (có thể thay đổi giao diện dựa trên dữ liệu).
  final Note _note; //Biến _note được khai báo với kiểu dữ liệu Note (giả định đây là một lớp lưu trữ thông tin của ghi chú).
  // Biến này được đánh dấu là final có nghĩa là giá trị của nó không thể thay đổi sau khi được khởi tạo.
  const EditNote(this._note, {super.key}); //hàm khởi tạo (constructor) của lớp EditNote
//Nó nhận một đối tượng Note làm tham số và gán cho biến _note.
// Từ khóa const được sử dụng để tạo ra một đối tượng EditNote không đổi.
  @override
  State<EditNote> createState() => _EditNoteState();//Phương thức này được gọi để tạo ra trạng thái (state) của widget EditNote.
//trả về một đối tượng của lớp _EditNoteState (lớp trạng thái riêng của EditNote).
}

class _EditNoteState extends State<EditNote> { //lớp con
  TextEditingController? title; //Biến title được khai báo với kiểu extEditingController?.
  // cho phép lưu trữ một đối tượng TextEditingController nhưng cũng có thể là null.
  // Dấu hỏi (?) thể hiện sự nullable.
  TextEditingController? subTitle; //Tương tự như title
  // biến subTitle cũng được khai báo với kiểu TextEditingController? để lưu trữ đối tượng quản lý văn bản nhập cho phần phụ đề.

  final FocusNode _focusNode1 = FocusNode();// Biến _focusNode1 được khai báo với kiểu final FocusNode và được khởi tạo với một đối tượng mới của lớp FocusNode.
  // Biến final nghĩa là giá trị không thể thay đổi sau khi khởi tạo.
  // FocusNode được sử dụng để theo dõi trạng thái focus của trường nhập liệu
  final FocusNode _focusNode2 = FocusNode(); //Tương tự _focusNode1
  // biến _focusNode2 cũng được dùng theo dõi trạng thái focus nhưng cho trường nhập liệu phần phụ đề.
  int indexx = 0;
  @override
  void initState() { // Phương thức initState được gọi ngay sau khi widget được khởi tạo.
    // thường được dùng để thiết lập các giá trị ban đầu cho các biến trạng thái.
    // TODO: implement initState
    super.initState(); //Gọi phương thức initState của lớp cha (StatefulWidget) để thực hiện các thiết lập mặc định.
    title = TextEditingController(text: widget._note.title); //Khởi tạo đối tượng TextEditingController cho biến title và thiết lập văn bản mặc định bằng với tiêu đề của ghi chú được truyền vào từ widget cha
    subTitle = TextEditingController(text: widget._note.subTitle); //Khởi tạo đối tượng TextEditingController cho biến subTitle và thiết lập văn bản mặc định bằng với phần phụ đề của ghi chú được truyền vào từ widget cha
  }

  @override
  Widget build(BuildContext context) { //khai báo phương thức build trả về một widget.
    // Tham số context là tham chiếu đến ngữ cảnh (context) của widget hiện tại.
    return Scaffold( //Widget chính để xây dựng cấu trúc cơ bản của màn hình.
      backgroundColor: Colors.white, //Thiết lập màu nền của màn hình thành màu trắng.
      body: SafeArea( //Widget chứa nội dung chính của màn hình
        // SafeArea đảm bảo nội dung không bị che bởi các phần trạng thái hệ thống (thanh thông báo, thanh điều hướng).
        child: Column( //Sắp xếp các widget con theo chiều dọc.
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            titleWidgets(),//Xây dựng widget để nhập tiêu đề ghi chú.
            const SizedBox(height: 20),
            subtiteWedgite(),//Xây dựng widget để nhập phần phụ đề ghi chú
            const SizedBox(height: 20),
            imagess(),//Xây dựng giao diện để chọn ảnh đại diện cho ghi chú
            const SizedBox(height: 20),
            button()//Xây dựng widget nút bấm
          ],
        ),
      ),
    );
  }

  Widget button() { //khai báo phương thức button trả về một widget.
    return Row( //sắp xếp các widget con theo hàng ngang.
      mainAxisAlignment: MainAxisAlignment.spaceAround, //căn chỉnh các nút bấm cách đều nhau trên hàng ngang.
      children: [
        ElevatedButton( //Widget nút bấm nổi bật.
          // Mỗi nút bấm được khai báo với hai thành phần:
          style: ElevatedButton.styleFrom( //Cấu hình kiểu dáng của nút bấm.
            shadowColor: Colors.grey, //Màu sắc của bóng đổ phía dưới nút bấm
            side: const BorderSide(color: Colors.black), //Khung viền của nút bấm
            backgroundColor: Colors.white, //Màu nền của nút bấm
            minimumSize: const Size(170, 48), //Kích thước tối thiểu của nút bấm
          ),
          onPressed: () { //Hàm xử lý khi người dùng click vào nút bấm
            StorageMethod().updateTask( //Gọi phương thức updateTask từ lớp StorageMethod để cập nhật ghi chú.
                widget._note.id, indexx, title!.text, subTitle!.text);
            //ID của ghi chú cần cập nhật
            //Giá trị của biến indexx
            //Văn bản tiêu đề ghi chú
            //Văn bản phần phụ đề ghi chú
            Navigator.pop(context); //Sau khi cập nhật ghi chú, đóng màn hình chỉnh sửa ghi chú bằng cách pop route (navigation) với context hiện tại.
            //đóng màn hình chỉnh sửa ghi chú mà không thực hiện cập nhật.
          },
          child: const Text( //định dạng text
            'Done',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
        ElevatedButton( //thiết lập các thuộc tính về kiểu dáng của nút bấm
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.grey,//Màu sắc của bóng đổ phía dưới nút bấm
            side: const BorderSide(color: Colors.black), //khung viền nút bấm
            backgroundColor: Colors.white, //màu nền nút bấm
            minimumSize: const Size(170, 48), //kích thước
          ),
          onPressed: () { //định nghĩa hành vi khi người dùng click vào nút bấm
            Navigator.pop(context); //Navigator.pop(context); : Chỉ đóng màn hình chỉnh sửa ghi chú mà không cập nhật bất kỳ thay đổi nào.
          },
          child: const Text(
            'Cancel', //nút canclel
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
    return SizedBox(
      height: 180, //Khởi tạo một SizedBox với chiều cao cố định 180 chứa danh sách cuộn ngang ListView.builder
      child: ListView.builder( //hiển thị 4 ảnh đại diện để người dùng lựa chọn cho ghi chú.
        itemCount: 4, //Thiết lập danh sách chứa 4 mục (4 ảnh).
        scrollDirection: Axis.horizontal, //Thiết lập cuộn danh sách theo chiều ngang
        itemBuilder: (context, index) { //Hàm này được gọi để xây dựng từng mục (item) trong danh sách.
          // Tham số index biểu thị vị trí của mục trong danh sách (bắt đầu từ 0).
          return GestureDetector( //Biến mục danh sách thành một widget nhận diện cử chỉ (click).
            onTap: () { //thực thi khi người dùng chạm và nhả tay trên mục
              setState(() { //Cập nhật giá trị của biến indexx bằng với chỉ số index của mục được chọn.
                indexx = index;
              });
            },
            child: Padding( //Thêm khoảng đệm cho nội dung bên trong mục
              padding: EdgeInsets.only(left: index == 0 ? 7 : 0),
              child: Container( //Khung chứa chính cho nội dung của mỗi mục
                decoration: BoxDecoration( // Thiết lập kiểu trang trí cho container:
                  borderRadius: BorderRadius.circular(10), //Boder bo tròn cho container
                  border: Border.all( //Khung viền cho container
                    width: 2,
                    color: indexx == index ? Colors.black : Colors.grey, //Nếu indexx bằng với index của mục hiện tại (được chọn), viền sẽ có màu đen.
                      //Ngược lại, viền sẽ có màu xám
                  ),
                ),
                width: 140,//Chiều rộng cố định của container
                margin: const EdgeInsets.all(8), //Khoảng cách ngoài (margin) xung quanh container
                child: Column(  //Sắp xếp các widget con theo chiều dọc bên trong container
                  children: [
                    Container( //Khung chứa cho ảnh đại diện
                      height: 120, //Chiều cao cố định của container ảnh
                      width: 120, //Chiều rộng cố định của container ảnh
                      decoration: BoxDecoration( //Thiết lập kiểu hiển thị ảnh
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage('assets/taskPicture/$index.png'), //Đường dẫn đến ảnh.
                          // Code sử dụng AssetImage để truy cập ảnh từ thư mục assets/taskPicture trên thiết bị.
                          //$index thay thế bằng chỉ số index của mục hiện tại, do đó mỗi mục sẽ hiển thị ảnh PNG khác nhau.
                          fit: BoxFit.cover, //Thuộc tính xác định cách hiển thị ảnh bên trong container
                            //Thiết lập ảnh phủ kín toàn bộ container, có thể bị cắt xén nếu tỷ lệ ảnh không khớp với container.
                        ),
                      ),
                    ),
                    const SizedBox(height: 10), //Thêm khoảng trống 10 pixel phía dưới ảnh đại diện
                    Text( //Widget hiển thị văn bản
                      index == 0
                          ? '#Study '
                          : index == 1
                              ? '#Healthy  '
                              : index == 2
                                  ? '#Work'
                                  : '#Other ',
                      //Nếu index là 0, hiển thị "#Study ".
                      // Tương tự với các điều kiện index == 1, index == 2, và index == 3 hiển thị các tiêu đề "#Healthy ", "#Work", và "#Other "
                      style: TextStyle( //Kiểu chữ hiển thị
                        color: indexx == index ? Colors.black : Colors.grey, //Màu sắc của chữ phụ thuộc vào biến indexx
                        //Nếu indexx bằng với index của mục hiện tại (được chọn), văn bản sẽ có màu đen.
                        // Ngược lại, văn bản sẽ có màu xám.
                        fontSize: 18, // Kích thước font chữ
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

  Widget titleWidgets() { //khai báo phương thức titleWidgets trả về một widget.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15), //Thêm khoảng đệm (padding) 15 pixel đối xứng cho nội dung bên trong (đệm ngang).
      child: Container( //Khung chứa chính cho widget nhập tiêu đề
        decoration: BoxDecoration( //Thiết lập kiểu trang trí cho container
          color: Colors.white, //Màu nền của container
          borderRadius: BorderRadius.circular(15), //Boder bo tròn cho container
        ),
        child: TextField( //Widget chính để người dùng nhập tiêu đề ghi chú
          controller: title, //Thuộc tính này liên kết TextField với biến title kiểu TextEditingController.
          // Bất kỳ văn bản nào người dùng nhập vào sẽ được lưu trữ trong biến title
          focusNode: _focusNode1, //Thuộc tính này liên kết TextField với biến _focusNode1 kiểu FocusNode.
          // được sử dụng để theo dõi trạng thái focus của trường nhập liệu (có đang được người dùng nhập liệu hay không)
          style: const TextStyle(fontSize: 18, color: Colors.black), //Kiểu chữ hiển thị trong TextField
          decoration: InputDecoration( //Thuộc tính này dùng để tùy chỉnh giao diện của TextField
              contentPadding: //Khoảng trống giữa nội dung văn bản và khung viền
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              hintText: 'What do you want to do today?',//Văn bản gợi ý xuất hiện khi TextField trống
              hintStyle: const TextStyle(color: Colors.grey), //Kiểu chữ của văn bản gợi ý.
              enabledBorder: OutlineInputBorder( //Khung viền khi TextField không được focus
                borderRadius: BorderRadius.circular(10), //Khung viền khi TextField đang được focus (được người dùng nhập liệu)
                borderSide: const BorderSide( //thiết lập đường viền cho khung của TextField
                  color: Colors.black, //Thiết lập màu sắc của đường viền
                  width: 1.0, //Thiết lập độ dày của đường viền
                ),
              ),
              focusedBorder: OutlineInputBorder( //Khung viền khi TextField đang được focus
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
      padding: const EdgeInsets.symmetric(horizontal: 15), //Thêm khoảng đệm (padding) 15 pixel đối xứng cho nội dung bên trong (đệm ngang).
      child: Container( //Khung chứa chính cho widget nhập phần phụ đề
        decoration: BoxDecoration( //Thiết lập kiểu trang trí cho container, giống như titleWidgets
          color: Colors.white, //Màu nền của container
          borderRadius: BorderRadius.circular(15), //Boder bo tròn cho container
        ),
        child: TextField( //Widget chính để người dùng nhập phần phụ đề ghi chú
          maxLines: 3, //Cho phép người dùng nhập văn bản trên nhiều dòng (tối đa 3 dòng)
          controller: subTitle, //Liên kết TextField với biến subTitle kiểu
          focusNode: _focusNode2, //Liên kết TextField với biến _focusNode2 kiểu FocusNode để theo dõi trạng thái focus.
          style: const TextStyle(fontSize: 18, color: Colors.black), //Kiểu chữ hiển thị trong TextField
          decoration: InputDecoration( //Tùy chỉnh giao diện TextField, giống với thiết lập trong titleWidgets
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15), //symmetric: Thiết lập padding đều nhau cho các phía
            //khoảng trống ngang vs dọc
            //Thiết lập khoảng trống (padding) giữa nội dung văn bản người dùng nhập và khung viền của TextField
            hintText: 'Can I know more about it?', //Văn bản gợi ý xuất hiện bên trong TextField khi người dùng chưa nhập gì.
            hintStyle: const TextStyle(color: Colors.grey), //Thiết lập kiểu chữ cho văn bản gợi ý. Màu sắc được thiết lập là màu xám
            enabledBorder: OutlineInputBorder( //Khung viền mặc định của TextField khi không được focus.
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
