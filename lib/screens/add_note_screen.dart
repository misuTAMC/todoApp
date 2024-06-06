import 'package:flutter/material.dart';
import 'package:tinhtoandidong_project/resources/storage_method.dart';

//https://drive.google.com/drive/folders/1DpJeQ97lwyMo4VxTzYNUEqr16L-X9Gdz?fbclid=IwZXh0bgNhZW0CMTAAAR1xmorck_jAF-peNLS8oU5exdEgIsLlRblBuJIWbckZtkRpBVRcuUaC6S4_aem_ATQlz_nzihR2RCuwAwHyAuYtvl963za-t-EOIbwawI7W1S_npKWroi1Ghj2qGhFocwEzL1WCb7AiV6zy-xWYMgwl
class AddNote extends StatefulWidget { //Dòng này khai báo một lớp mới tên là AddNote kế thừa các chức năng từ lớp StatefulWidget.
  const AddNote({super.key}); // Dòng này định nghĩa hàm tạo cho lớp AddNote
                              // super.key: Ký hiệu này gọi hàm tạo của lớp cha (StatefulWidget) và truyền một khóa. Khóa là một định danh duy nhất được Flutter sử dụng để quản lý các widget trong giao diện người dùng.
  @override
  State<AddNote> createState() => _AddNoteState(); //Phương thức này được yêu cầu bởi StatefulWidget. Nó tạo và trả về đối tượng trạng thái được liên kết với widget AddNote. Trong trường hợp này, nó tạo một thể hiện của một lớp riêng tư tên là _AddNoteState để quản lý trạng thái của widget.
}

class _AddNoteState extends State<AddNote> { //Dòng này khai báo một lớp riêng tư tên là _AddNoteState kế thừa từ lớp State<AddNote>
  final title = TextEditingController(); //TextEditingController: Là một lớp tiện ích trong Flutter được sử dụng để quản lý văn bản nhập vào bởi người dùng trong các trường văn bản (TextField).
  //final: Từ khóa này khai báo title là một biến bất biến, giá trị không thể thay đổi sau khi được khởi tạo.
  //= TextEditingController();: Khởi tạo biến title với một đối tượng TextEditingController mới.
  final subtitle = TextEditingController(); //quản lý văn bản nhập vào cho phần phụ đề (subtitle) của ghi chú.

  final FocusNode _focusNode1 = FocusNode(); //FocusNode: Là một lớp tiện ích trong Flutter được sử dụng để quản lý trạng thái focus của các widget nhập văn bản (TextField). Focus cho biết TextField nào đang được người dùng nhập liệu.
  // final: Tương tự như trên, khai báo _focusNode1 là một biến bất biến.
  // = FocusNode();: Khởi tạo biến _focusNode1 với một đối tượng FocusNode mới.
  final FocusNode _focusNode2 = FocusNode(); //như F1
  int indexx = 0; //kiểu int và khởi tạo giá trị bằng 0. Biến này có thể được sử dụng để theo dõi thứ tự hoặc trạng thái nào đó liên quan đến việc thêm ghi chú.
  @override
  Widget build(BuildContext context) { //build là một phương thức bắt buộc phải có trong StatefulWidget.
    //BuildContext context: Tham số context cung cấp thông tin về vị trí của widget trong cây widget của ứng dụng Flutter.
    return Scaffold( //rả về một widget kiểu Scaffold
      //một widget tiện ích trong Flutter cung cấp cấu trúc cơ bản cho hầu hết các màn hình trong ứng dụng. Nó bao gồm thanh app bar (AppBar), thân chính (body) và thanh điều hướng dưới (BottomNavigationBar) (tùy chọn).
      backgroundColor: Colors.white, //Cài đặt màu nền của màn hình thành trắng.
                                     //Thuộc tính backgroundColor của Scaffold cho phép tùy chỉnh màu nền của toàn bộ màn hình.
      body: SafeArea( //đặt nội dung chính của màn hình (body) bên trong một widget SafeArea
                      //đảm bảo nội dung của widget con tránh khỏi các notch hoặc camera cutout trên một số thiết bị.
        child: Column(  //tạo một widget Column để xếp chồng các widget con theo chiều dọc
          mainAxisAlignment: MainAxisAlignment.center, //
          children: [
            titleWidgets(), //gọi đến một phương thức khác có tên titleWidgets
                            //xây dựng các widget liên quan đến tiêu đề của ghi chú, chẳng hạn như TextField để nhập tiêu đề.
            const SizedBox(height: 20), //khoảng trống cố định với chiều cao 20 pixel.
            //sizebox tạo khoảng trắng phù hợp với giao diện
            subtiteWedgite(),//widget liên quan đến phần phụ đề của ghi chú
            const SizedBox(height: 20),
            imagess(), //hiển thị hình ảnh
            const SizedBox(height: 20),
            button() //nút nhấn, nút lưu ghi chú
          ],
        ),
      ),
    );
  }

  Widget button() { //xây dựng widget nút bấm (button) để thêm ghi chú và nút hủy (cancel).
    return Row( //xếp các widget con theo hàng ngang
      mainAxisAlignment: MainAxisAlignment.spaceAround, // sắp xếp các widget con của chúng dọc theo một trục duy nhất
                                                        //giá trị từ enum MainAxisAlignment chỉ định cách sắp xếp các widget con
      children: [
        ElevatedButton( //nút thêm có hiệu ứng nổi khối
          style: ElevatedButton.styleFrom( //tùy chỉnh kiểu dáng của nút Thêm
            shadowColor: Colors.grey, //đổ bóng
            side: const BorderSide(color: Colors.black), //màu viền
            backgroundColor: Colors.white,//thiết lập màu nền là trắng
            minimumSize: const Size(170, 48), //kích thước
          ),
          onPressed: () { //thiết lập hành vi khi nút Thêm được nhấn
            StorageMethod().addTask(subtitle.text, title.text, indexx); //gọi đến phương thức addTask từ một lớp có tên StorageMethod.
            //có khả năng chịu trách nhiệm thêm ghi chú mới vào một loại lưu trữ nào đó, chẳng hạn như cơ sở dữ liệu hoặc bộ nhớ cục bộ.
            //subtitle.text: văn bản được nhập vào trường phụ đề của ghi chú.
            //title.text: văn bản được nhập vào trường tiêu đề của ghi chú.
            //indexx: Đây là biến có tên indexx được sử dụng để xác định vị trí của ghi chú hoặc cho các mục đích khác liên quan đến cơ chế lưu trữ.
            Navigator.pop(context); //loại bỏ màn hình hiện tại khỏi ngăn xếp điều hướng.
                                    //đóng màn hình AddNote và quay lại màn hình trước
                                    //context:tham chiếu đến ngữ cảnh hiện tại, cần thiết cho các thao tác điều hướng.
          }, //Khối lệnh bên trong ngoặc nhọn {} sẽ được thực thi khi người dùng chạm và nhả tay trên nút.
          child: const Text( //đặt nội dung (văn bản) hiển thị trên nút Thêm
            'Add',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
        ElevatedButton( //tạo ra một nút bấm kiểu ElevatedButton thứ hai, đóng vai trò là nút Hủy.
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.grey,
            side: const BorderSide(color: Colors.black),
            backgroundColor: Colors.white,
            minimumSize: const Size(170, 48),
          ),
          onPressed: () {
            Navigator.pop(context); //dùng để đóng (pop) màn hình thêm ghi chú và quay lại màn hình trước đó, tương tự như nút Thêm nhưng không thực hiện lưu trữ ghi chú.
          },
          child: const Text(
            'Cancel', //Cấu hình và nội dung của nút Hủy tương tự như nút Thêm, chỉ khác ở nội dung hiển thị ('Cancel').
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

  SizedBox imagess() { //xây dựng giao diện để người dùng chọn một ảnh đại diện cho ghi chú.
    return SizedBox(
      height: 180,
      child: ListView.builder( ////tạo một danh sách cuộn ngang
        //cho phép người dùng cuộn để xem tất cả các mục nếu danh sách vượt quá chiều rộng màn hình
        //xây dựng từng mục item: builder
        itemCount: 4,
        scrollDirection: Axis.horizontal, // Thiết lập hướng cuộn của danh sách là ngang.
        itemBuilder: (context, index) { //xây dựng từng mục trong danh sách.
          return GestureDetector( //Biến mục danh sách thành một widget nhận diện cử chỉ
            //Cho phép người dùng tương tác (bấm) vào mục để chọn ảnh.
            onTap: () { //được thực thi khi người dùng chạm và nhả tay trên mục.
              setState(() { //cập nhật trạng thái của widget AddNote
                indexx = index;
              });
            },
            child: Padding( //Thêm khoảng đệm (padding) cho nội dung bên trong.
              padding: EdgeInsets.only(left: index == 0 ? 7 : 0), //Khoảng đệm bên trái phụ thuộc vào chỉ số index để tạo ra khoảng cách lề lớn hơn cho mục đầu tiên.
              child: Container( //Khung chứa chính cho nội dung của mỗi mục.
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
          border: Border.all( //Khung viền cho container
                    width: 2, //
                    color: indexx == index ? Colors.black : Colors.grey,
                  ),
                ),
                width: 140, //Chiều rộng cố định của container
                margin: const EdgeInsets.all(8), //Khoảng cách ngoài (margin) xung quanh container
                child: Column( //Sắp xếp các widget con theo chiều dọc bên trong container.
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration( //Thiết lập kiểu hiển thị ảnh.
                        borderRadius: BorderRadius.circular(10), //Giữ bo tròn cho ảnh giống với container
                        image: DecorationImage(
                          image: AssetImage('assets/taskPicture/$index.png'), //sử dụng AssetImage để truy cập ảnh từ thư mục assets/taskPicture/ với tên index.png
                          fit: BoxFit.cover, //khớp nối ảnh (BoxFit.cover) để lấp đầy toàn bộ container.
                        ),
                      ),
                    ),
                    const SizedBox(height: 10), //Khoảng trống cố định 10 pixel giữa hình ảnh và tiêu đề
                    //Text(Nội dung văn bản phụ thuộc vào chỉ số index.
                    //Kiểu chữ và màu sắc phụ thuộc vào biến indexx (giống như viền của container) để làm nổi bật mục được chọn.
                      index == 0
                          ? '#Study '
                          : index == 1
                              ? '#Healthy  '
                              : index == 2
                                  ? '#Work'
                                  : '#Other ',
                      style: TextStyle(
                        color: indexx == index ? Colors.black : Colors.grey,
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
    return Padding( //Thêm khoảng đệm (padding) cho nội dung bên trong
      padding: const EdgeInsets.symmetric(horizontal: 15), //
      child: Container( //Khung chứa chính cho widget nhập tiêu đề.
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField( //Widget chính để người dùng nhập tiêu đề ghi chú.
          controller: title, //Thuộc tính liên kết TextField với biến title kiểu TextEditingController.
          // Bất kỳ văn bản nào người dùng nhập vào sẽ được lưu trữ trong biến title
          focusNode: _focusNode1, //Thuộc tính liên kết TextField với biến _focusNode1 kiểu FocusNode.
          // Nó được sử dụng để theo dõi trạng thái focus của trường nhập liệu (có đang được người dùng nhập liệu hay không).
          style: const TextStyle(fontSize: 18, color: Colors.black), //Kiểu chữ hiển thị trong TextField.
          decoration: InputDecoration( //Thuộc tính dùng để tùy chỉnh giao diện của TextField
              contentPadding: //Khoảng trống giữa nội dung văn bản và khung viền.
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              hintText: 'What do you want to do today?', //Văn bản gợi ý xuất hiện khi TextField trống
              hintStyle: const TextStyle(color: Colors.grey), //Kiểu chữ của văn bản gợi ý.
              enabledBorder: OutlineInputBorder( //Khung viền khi TextField không được focus.
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder( //Khung viền khi TextField đang được focus (được người dùng nhập liệu).
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

  Padding subtiteWedgite() { //khai báo phương thức subtiteWedgite trả về một widget kiểu Padding
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15), //thiết lập khoảng đệm (padding) 15 pixel đối xứng cho nội dung bên trong (đệm ngang).
      child: Container( //Khung chứa chính cho widget nhập phần phụ đề.
        decoration: BoxDecoration( //Thiết lập kiểu trang trí cho container
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField( //Widget chính để người dùng nhập phần phụ đề của ghi chú
          maxLines: 3, //Cho phép người dùng nhập tối đa 3 dòng văn bản
          controller: subtitle, //liên kết TextField với biến subtitle kiểu TextEditingController.
          // Bất kỳ văn bản nào người dùng nhập vào sẽ được lưu trữ trong biến subtitle
          focusNode: _focusNode2, //liên kết TextField với biến _focusNode2 kiểu FocusNode.
          // Nó được sử dụng để theo dõi trạng thái focus của trường nhập liệu (có đang được người dùng nhập liệu hay không).
          style: const TextStyle(fontSize: 18, color: Colors.black), //Kiểu chữ hiển thị trong TextField
          decoration: InputDecoration( //Thuộc tính này dùng để tùy chỉnh giao diện của TextField
            contentPadding: //Khoảng trống giữa nội dung văn bản và khung viền.
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: 'Can I know more about it?', //Văn bản gợi ý xuất hiện khi TextField trống.
            hintStyle: const TextStyle(color: Colors.grey), //Kiểu chữ của văn bản gợi ý.
            enabledBorder: OutlineInputBorder( //Khung viền khi TextField không được focus.
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder( //Khung viền khi TextField đang được focus (được người dùng nhập liệu).
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
