// ignore_for_file: avoid_print

// Nhập thư viện dart:math từ Dart SDK, cung cấp các hàm và hằng số toán học cơ bản. Ví dụ: Random, pi, cos, sin, v.v.
import 'dart:math';

/* Nhập thư viện material.dart từ Flutter SDK, cung cấp các widget và lớp cần thiết để xây dựng giao diện người dùng
theo phong cách Material Design của Google.*/
import 'package:flutter/material.dart';
/* Nhập thư viện auth_method.dart từ thư mục resources dự án tinhtoandidong_project. 
Thư viện này có thể chứa các phương thức liên quan đến xác thực người dùng (ví dụ: đăng nhập, đăng ký, đăng xuất).*/
import 'package:tinhtoandidong_project/resources/auth_method.dart';
/* Nhập thư viện mobile_screen_layout.dart từ thư mục responsive trong dự án tinhtoandidong_project. 
Thư viện này có thể chứa bố cục giao diện dành riêng cho các thiết bị di động.*/
import 'package:tinhtoandidong_project/responsive/mobile_screen_layout.dart';
/* Nhập thư viện responsive_layout_screen.dart từ thư mục responsive trong dự án tinhtoandidong_project. 
Thư viện này có thể chứa bố cục giao diện đáp ứng, điều chỉnh linh hoạt cho các kích thước màn hình khác nhau (ví dụ: di động, máy tính bảng, máy tính để bàn).*/
import 'package:tinhtoandidong_project/responsive/responsive_layout_screen.dart';
/* Nhập thư viện web_screen_layout.dart từ thư mục responsive trong dự án tinhtoandidong_project. 
Thư viện này có thể chứa bố cục giao diện dành riêng cho các thiết bị màn hình lớn hoặc trình duyệt web.*/
import 'package:tinhtoandidong_project/responsive/web_screen.layout.dart';
/* Nhập thư viện signup_screen.dart từ thư mục screens trong dự án tinhtoandidong_project. 
Thư viện này có thể chứa màn hình đăng ký người dùng.*/
import 'package:tinhtoandidong_project/screens/signup_screen.dart';
/* Nhập thư viện utils.dart từ thư mục utils trong dự án tinhtoandidong_project. 
Thư viện này có thể chứa các hàm tiện ích hỗ trợ các tác vụ khác nhau trong ứng dụng (ví dụ: xử lý chuỗi, hiển thị thông báo).*/
import 'package:tinhtoandidong_project/utils/utils.dart';
/* Nhập thư viện logo_app.dart từ thư mục widgets trong dự án tinhtoandidong_project. 
Thư viện này có thể chứa một widget tùy chỉnh để hiển thị logo của ứng dụng.*/
import 'package:tinhtoandidong_project/widgets/logo_app.dart';
/* Nhập thư viện text_field_input.dart từ thư mục widgets trong dự án tinhtoandidong_project. 
Thư viện này có thể chứa một widget tùy chỉnh cho các trường nhập liệu trong ứng dụng.*/
import 'package:tinhtoandidong_project/widgets/text_field_input.dart';

// Định nghĩa một widget có trạng thái cho màn hình đăng nhập.
class LoginScreen extends StatefulWidget { 
// Lớp LoginScreen kế thừa từ StatefulWidget, tức là widget này có trạng thái và trạng thái của nó có thể thay đổi trong suốt vòng đời của nó.
  const LoginScreen({super.key});
/* const LoginScreen({super.key});: Khai báo một constructor cho lớp LoginScreen. 
Từ khóa const chỉ ra rằng constructor này tạo ra một đối tượng bất biến, có thể được tạo tại thời điểm biên dịch 
nếu tất cả các đối số của nó đều là hằng số. super.key chuyển key đến constructor của lớp cha StatefulWidget. key 
là một tham số quan trọng trong Flutter giúp định danh các widget trong cây widget.*/
  @override // Phương thức tiếp theo sẽ ghi đè một phương thức có cùng tên trong lớp cha
  State<LoginScreen> createState() => _LoginScreenState(); // Tạo trạng thái cho widget.
}

class _LoginScreenState extends State<LoginScreen> {
  //*tao 2 bien de luu gia tri cua email va password mà người dùng nhập vào
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //*tao 1 bien de kiem tra xem nguoi dung da nhap email va password chua
  bool _isFilled = false;
  //*tao 1 bien de kiem tra xem nguoi dung co dang nhap hay khong
  bool _isLoading = false;
  double opacityValue = 1.0;
  @override
  void dispose() { // Phương thức hủy để giải phóng tài nguyên khi widget bị loại bỏ.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _checkIfFilled() {
    setState(() {
      //*kiem tra xem nguoi dung da nhap email va password chua
      //*neu da nhap thi _isFilled=true
      //*neu chua nhap thi _isFilled=false
      _isFilled = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

// Định nghĩa một phương thức bất đồng bộ tên `loginUser`
  void loginUser() async {
    // Đặt trạng thái `_isLoading` thành `true`, có thể được sử dụng để hiển thị một spinner loading trong UI
    setState(() {
      _isLoading = true;
    });

    // Gọi phương thức `logInUser` từ lớp `AuthMethods` để thực hiện việc đăng nhập
    // Phương thức này nhận vào email và mật khẩu từ các controller tương ứng
    // Kết quả trả về (một chuỗi) được lưu vào biến `res`
    String res = await AuthMethods().logInUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    // In kết quả ra console
    print(res);

    // Kiểm tra kết quả
    if (res == "Success dang nhap:o auth_method.dart") {
      // Nếu thành công, điều hướng người dùng đến màn hình mới (`ResponsiveLayout`)
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    } else {
      // Nếu không thành công, hiển thị một Snackbar với thông báo lỗi
      showSnackBar(context, res);
      // In lỗi ra console
      print("loi dang nhap: $res");
    }

    // Cuối cùng, đặt `_isLoading` trở lại `false` để ẩn spinner loading
    setState(() {
      _isLoading = false;
    });
  }

  Color getRandomColor() {
    return Color.fromARGB(
      255,
      200 + Random().nextInt(56), // Red value will be between 200 and 255
      200 + Random().nextInt(56), // Green value will be between 200 and 255
      200 + Random().nextInt(56), // Blue value will be between 200 and 255
    );
  }

  //*tao 1 phuong thuc de chuyen huong den signup_screen
  void navigatorToSignup() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const SignupScreen();
    }));
  }

  @override
  Widget build(BuildContext context) { // Xây dựng giao diện người dùng cho màn hình đăng nhập.
    return Scaffold( // Sử dụng widget Scaffold để tạo khung cơ bản cho giao diện.
      backgroundColor: Colors.white, // Đặt màu nền của scaffold là màu trắng.
      body: Stack( // Thiết lập nội dung chính của scaffold là một widget Stack. Stack cho phép xếp chồng các widget lên nhau.
        fit: StackFit.expand, //Thiết lập fit của stack để phù hợp với kích thước của stack.
        children: [
          Positioned( // Widget Positioned được sử dụng để định vị một widget con ở một vị trí cụ thể trong stack.
            // Đặt vị trí của widget là top: 600 pixels từ đỉnh và left: 200 pixels từ cạnh trái của màn hình.
            top: 600,
            left: 200,
            // Widget AnimatedOpacity cho phép thay đổi độ mờ của widget con theo thời gian.
            child: AnimatedOpacity(
              opacity: opacityValue, // Thiết lập độ mờ của widget dựa trên giá trị của biến opacityValue.
              duration: const Duration(seconds: 2), // Đặt thời gian mà hiệu ứng opacity sẽ diễn ra là 2 giây.
              child: Padding( // Sử dụng widget Padding để thêm khoảng trống xung quanh một widget con.
                padding: // Thiết lập khoảng trống ngang và dọc cho widget con là 15 pixels.
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Transform.rotate( // Widget Transform.rotate được sử dụng để xoay một widget con với góc nhất định.
                  angle: 0.2, // Đặt góc xoay của widget con là 0.2 radians (khoảng 11.46 độ).
                  child: Container( // Widget Container dùng để tạo một hộp chứa có thể được tùy chỉnh.
                    // Đặt chiều rộng của container là 300 pixels và chiều cao là 350 pixels.
                    width: 300,
                    height: 350,
                    // Sử dụng BoxDecoration để định dạng hình dạng và hình ảnh nền của container.
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black), // Đặt viền container là một đường kẻ màu đen.
                      borderRadius: BorderRadius.circular(40), // Bo tròn góc của container với bán kính 40 pixels.
                      // Đặt màu nền của container bằng một màu ngẫu nhiên.
                      color: getRandomColor(),
                      // Thuộc tính boxShadow được sử dụng để định nghĩa các hiệu ứng shadow cho container. Nó là một danh sách các đối tượng BoxShadow.
                      boxShadow: [
                        BoxShadow( // Mỗi BoxShadow đại diện cho một hiệu ứng shadow cụ thể.
                          // color là thuộc tính xác định màu của shadow.
                          //Trong trường hợp này, shadow có màu xám (Colors.grey) với độ mờ là 50% (0.5) của màu gốc.
                          color: Colors.grey.withOpacity(0.5), 
                          // spreadRadius xác định sự lan rộng của shadow ra xung quanh container. 
                          //Trong trường hợp này, shadow được lan rộng 5 pixels từ tâm của container ra ngoài.
                          spreadRadius: 5,
                          // blurRadius xác định mức độ mờ của shadow. Trong trường hợp này, shadow có mức độ mờ là 7 pixels.
                          blurRadius: 7,
                          // offset xác định vị trí của shadow. Trong trường hợp này, shadow được đặt về phía trái của container (-5 pixels theo trục X) 
                          // và không có sự thay đổi theo trục Y (0 pixels). Điều này tạo ra hiệu ứng shadow phía bên trái của container.
                          offset: const Offset(-5, 0),
                        ),
                      ],
                    ),
                    child: const Padding( // Sử dụng padding để tạo khoảng trống trong container để chứa nội dung.
                      // Thuộc tính padding định nghĩa kích thước của khoảng trống, ở đây là 20 pixels ở mỗi cạnh.
                      padding: EdgeInsets.all(20.0), 
                      child: Column( // Widget Column được sử dụng để xếp các widget con theo hướng dọc.
                        // Thuộc tính crossAxisAlignment xác định cách các widget con được căn chỉnh theo chiều ngang. 
                        // Trong trường hợp này, các widget con được căn chỉnh theo phía trái.
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [ 
                          Row( // Widget Row được sử dụng để xếp các widget con theo hướng ngang.
                            // Thuộc tính mainAxisAlignment xác định cách các widget con trong hàng được căn chỉnh theo chiều dọc. 
                            // Trong trường hợp này, các widget con được căn chỉnh theo cách để chúng chia đều khoảng trống giữa chúng.
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded( // Widget Expanded mở rộng widget con để nó sử dụng tất cả không gian còn trống trong hàng.
                                // Widget Text được sử dụng để hiển thị văn bản. 
                                // Trong trường hợp này, văn bản được hiển thị là "Today is a new day!".
                                child: Text(
                                  'Today is a new day!',
                                  // Thuộc tính maxLines xác định số lượng dòng tối đa mà văn bản có thể hiển thị.
                                  // Trong trường hợp này, nó được đặt thành 2 dòng.
                                  maxLines: 2,
                                  // Thuộc tính overflow xác định cách xử lý khi văn bản vượt quá số dòng tối đa.
                                  // TextOverflow.ellipsis có nghĩa là nếu văn bản bị tràn, thì dấu "..." sẽ được hiển thị.
                                  overflow: TextOverflow.ellipsis,
                                  // Thuộc tính style xác định các thuộc tính về kiểu chữ của văn bản.
                                  style: TextStyle(
                                    fontSize: 30, // Đặt kích thước của văn bản là 30 pixels.
                                    fontWeight: FontWeight.w400, // Xác định độ đậm của văn bản (FontWeight.w400 tương ứng với font chữ regular).
                                    color: Colors.black, // Đặt màu chữ của văn bản là đen.
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Widget Divider được sử dụng để vẽ một đường ngang.
                          Divider(
                            color: Colors.black,
                            thickness: 1, // Độ dày được đặt là 1 pixel.
                          ),
                          // Widget SizedBox được sử dụng để thêm một khoảng trống dọc có chiều cao là 10 pixels.
                          SizedBox(height: 10),
                          // Widget Text khác được sử dụng để hiển thị một đoạn văn bản.
                          // Trong trường hợp này, văn bản được hiển thị là "Don't read ... up now!".
                          Text(
                            'Don\'t read this. It\'s just a dummy text. But if you are reading this, then you are wasting your time. So stop reading this and sign up now!.',
                            maxLines: 16,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300, // font chữ Light
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            // widget được đặt ở vị trí có tọa độ (50, 450).
            top: 450,
            left: 50,
            // Đây là một child widget của Positioned, được sử dụng để thay đổi độ mờ của widget con dựa trên giá trị của thuộc tính opacity.
            child: AnimatedOpacity(
              // Thuộc tính opacity xác định độ mờ của widget con. Giá trị của nó được lấy từ biến opacityValue.
              opacity: opacityValue,
              // Thuộc tính duration xác định thời gian mà hiệu ứng opacity sẽ diễn ra. Trong trường hợp này, nó được đặt thành 4 giây.
              duration: const Duration(seconds: 4),
              child: Padding( // Widget Padding được sử dụng để tạo một khoảng trống xung quanh nội dung của nó.
                // nội dung bên trong widget Padding sẽ được bao bọc trong một khoảng trống 
                // với kích thước 15 pixels ở mỗi phía (trên, dưới, trái và phải).
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Transform.rotate(
                  // Widget Transform.rotate được sử dụng để xoay nội dung của nó.
                  // Trong trường hợp này, nội dung sẽ được xoay một góc -0.1 radian.
                  angle: -0.1,
                  child: Container( // Widget Container dùng để chứa và vẽ nội dung.
                    // container sẽ có kích thước rộng 300 pixels và cao 350 pixels.
                    width: 300,
                    height: 350,
                    // Thuộc tính decoration xác định các thuộc tính liên quan đến việc trang trí của container,
                    // bao gồm màu sắc, đường viền, và hiệu ứng shadow.
                    decoration: BoxDecoration( 
                      // Tạo ra một đường viền với màu đen, với độ dày và kiểu đường mặc định.
                      border: Border.all(color: Colors.black),
                      // Tạo ra góc bo tròn với bán kính là 40 pixels.
                      borderRadius: BorderRadius.circular(40),
                      // Lấy một màu sắc ngẫu nhiên.
                      color: getRandomColor(),
                      boxShadow: [
                        BoxShadow(
                          // Thuộc tính color xác định màu sắc của bóng. Ở đây, bóng có màu xám được tạo ra bằng cách sử dụng Colors.grey
                          // và làm mờ nó với độ mờ là 0.5 bằng cách sử dụng opacity.
                          color: Colors.grey.withOpacity(0.5),
                          // Bóng được phân tán ra 5 pixels từ tâm của container.
                          spreadRadius: 5,
                          // Bóng được làm mờ với bán kính là 7 pixels, tạo ra hiệu ứng mờ nhẹ.
                          blurRadius: 7,
                          // Tạo ra một hiệu ứng bóng nằm ở phía bên trái của container.
                          offset: const Offset(-5, 0),
                        ),
                      ],
                    ),
                    child: const Padding(
                      // Đặt khoảng cách 20 pixels từ mỗi phía của widget.
                      padding: EdgeInsets.all(20.0),
                      child: Column( // Đây là một child widget của container, một Column được sử dụng để xếp các widget con theo hướng dọc.
                        // Đặt các widget con bắt đầu từ bên trái của Column.
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [ // Xác định danh sách các widget con của Column
                          Row( // Xếp các widget con theo hướng ngang.
                            // Đặt các widget con sao cho chúng được căn chỉnh một cách đều đặn theo chiều dọc,
                            // với khoảng trống đều nhau 
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [ // Xác định danh sách các widget con của Row
                              Expanded( // Để sử dụng không gian còn trống trong Row.
                                child: Text(
                                  '#TODO: Add some tasks',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Don\'t read this. It\'s just a dummy text. But if you are reading this, then you are wasting your time. So stop reading this and sign up now!.',
                            maxLines: 15,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // SingleChildScrollView là một widget cho phép nội dung của nó được cuộn khi không khớp với màn hình.
          SingleChildScrollView( 
            child: Padding(
              // Khoảng cách là 20 pixels ở mỗi bên (trái và phải).
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column( // Dọc
                // Đặt các widget con được căn giữa theo chiều ngang.
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Một widget SizedBox với chiều cao là 200 pixels để tạo ra một khoảng trống.
                  const SizedBox(height: 200),
                  // Hiển thị logo.
                  const LogoApp(),
                  const SizedBox(height: 20),
                  // Email TextField
                  TextFieldInput( 
                    // Đây là một callback được gọi mỗi khi giá trị trong TextField thay đổi.
                    // Ở đây, khi người dùng nhập hoặc chỉnh sửa nội dung của ô nhập,
                    // _checkIfFilled() sẽ được gọi để kiểm tra xem các ô nhập có được điền đầy đủ hay không.
                    onChanged: (value) => _checkIfFilled(),
                    // textEditingController xác định một TextEditingController để quản lý nội dung của TextField.
                    // Ở đây, _emailController là một TextEditingController được sử dụng để lưu trữ và kiểm soát nội dung của ô nhập.
                    textEditingController: _emailController,
                    // hintText là một chuỗi văn bản hiển thị trong TextField khi nó không có giá trị.
                    // Ở đây, "Enter your email" sẽ hiển thị trong ô nhập cho người dùng biết họ nên nhập gì.
                    hintText: 'Enter your email',
                    // Cho biết TextField sẽ chứa một địa chỉ email.
                    textInputType: TextInputType.emailAddress,
                    // Đặt màu nền của ô nhập là màu trắng.
                    fillColor: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  // Password TextField
                  TextFieldInput(
                    onChanged: (value) => _checkIfFilled(),
                    textEditingController: _passwordController,
                    hintText: 'Enter your password',
                    textInputType: TextInputType.visiblePassword,
                    fillColor: Colors.white,
                    isPass: true,
                  ),
                  // Tạo ra một khoảng trống dọc có chiều cao là 16 pixels
                  const SizedBox(height: 16),
                  // Login Button
                  InkWell(
                    //*neu _isFilled=true thi khi click vao button thi se goi loginUser,nguoc lai thi khong lam gi
                    onTap: _isFilled ? loginUser : null,
                    child: AnimatedOpacity(
                      opacity: _isFilled ? 1 : 0,
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        width: 150,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          color: Color.fromARGB(163, 24, 24, 0),
                        ),
                        //*neu _isLoading=true thi hien thi CircularProgressIndicator,nguoc lai hien thi Text('Log in')
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Log in',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 320),
                  // Sign Up Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          'Don\'t have an account yet?',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: GestureDetector(
                          onTap: navigatorToSignup,
                          child: const Text(
                            ' Sign up',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
