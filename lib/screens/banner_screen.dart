import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tinhtoandidong_project/screens/login_screen.dart';

/*BannerScreen là một StatefulWidget =>có trạng thái thay đổi trong suốt thời gian tồn tại của nó.
  -Constructor BannerScreen chấp nhận một key như là tham số tùy chọn.
  -Phương thức createState tạo và trả về một thể hiện của _BannerScreenState,
lớp này sẽ chứa trạng thái và logic hiển thị cho BannerScreen.*/
class BannerScreen extends StatefulWidget {
  const BannerScreen({super.key});

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  double opacityValue =
      1.0; //thuộc tính trạng thái quản lý độ mờ của các widget AnimatedOpacity. Mặc định = 1.0 (hoàn toàn không trong suốt).

//*hàm này sẽ trả về một màu ngẫu nhiên liên tục mỗi lần được gọi
  Color getRandomColor() {
    return Color.fromARGB(
      255,
      200 + Random().nextInt(56), // Red value will be between 128 and 255
      200 + Random().nextInt(56), // Green value will be between 128 và 255
      200 + Random().nextInt(56), // Blue value will be between 128 và 255
    );
  }

  @override
  Widget build(BuildContext context) {
    // định nghĩa hàm build để xây dựng giao diện cho widget
    return Scaffold(
      //Scaffold: khung giao diện tiêu chuẩn trong flutter
      backgroundColor: Colors.white,
      body: GestureDetector(
        //body chứa widget (GestureDectector: phát hiện cử chỉ chạm, vuốt)
        onTap: () {
          //khi click vào
          setState(() {
            opacityValue = opacityValue == 1.0
                ? 0.0
                : 1.0; //thay doi opacity thanh 0 va nguoc lai la 1
          });
          Future.delayed(const Duration(seconds: 5), () {
            //sau 5s chuyên qua login
            Navigator.pushReplacement(
              //là một phương thức của Navigator để thay thế màn hình hiện tại bằng một màn hình mới.
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          });
        },
        child: Stack(
          //stack cho phép xếp chông các widget
          fit: StackFit.expand, //stack mở rộng hết kích thước widget cha
          children: [
            const SizedBox(height: 10),
            Positioned(
              top: 10,
              child: AnimatedOpacity(
                //thay đổi độ mờ (opacity) của widget con liên tục cách 1s
                opacity: opacityValue,
                duration: const Duration(seconds: 1),
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    Container(
                      alignment: Alignment.center,
                      height: 400,
                      width: 300,
                      child: const Text(
                        'You suck at taking notes brother,you need us :)',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 500, //sv stack
              left: 260,
              child: AnimatedOpacity(
                opacity: opacityValue,
                duration: const Duration(seconds: 2),
                child: Padding(
                  padding: //khoảng trống xung quanh widget con
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Transform.rotate(
                    angle: 0.2, //xoay 0.2 radian
                    child: Container(
                      width: 300,
                      height: 350,
                      margin: const EdgeInsets.only(
                          bottom: 10), // Adjust margin here
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius:
                            BorderRadius.circular(40), //bo tròn gốc 40 đv
                        color: getRandomColor(),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5, //Bán kính lan rộng của bóng đổ
                            blurRadius: 7,
                            offset: const Offset(
                                -5, 0), //Độ lệch của bóng đổ sang trái 5 đv
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, //Căn chỉnh các widget con theo cạnh bắt đầu của trục ngang.
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween, //Căn chỉnh các widget con sao cho khoảng cách giữa chúng được phân phối đều.
                              children: [
                                Expanded(
                                  //mở rộng child để chiếm không gian
                                  child: Text(
                                    '#We\'ve got your back!',
                                    maxLines:
                                        2, //Giới hạn số dòng của văn bản tối đa là 2. Nếu văn bản dài hơn 2 dòng, nó sẽ bị cắt bớt.
                                    overflow: TextOverflow
                                        .ellipsis, //Nếu văn bản bị cắt bớt do vượt quá số dòng tối đa, sẽ có dấu ba chấm (...) xuất hiện ở cuối để chỉ rằng văn bản đã bị cắt.
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
                              // đường kẻ chia tiêu đề vs nội dung
                              color: Colors.black,
                              thickness: 1,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'We know that studying can be tough, but we are here to help. Our team of experts will help you with everything from choosing the right course to finding the best study materials. So what are you waiting for? Sign up now and start your journey to success!',
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
            Positioned(
              top: 400,
              left: 50,
              child: AnimatedOpacity(
                opacity: opacityValue,
                duration: const Duration(seconds: 3),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Transform.rotate(
                    angle: -0.2,
                    child: Container(
                      width: 300,
                      height: 350,
                      margin: const EdgeInsets.only(
                          bottom: 10), // Adjust margin here
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(40),
                        color: getRandomColor(),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(-5, 0),
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    '#Not sure where to start? Tap here!',
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
                              'Don\'t worry, we got you covered. Our team of experts will help you get started on your journey to success. We will help you with everything from choosing the right course to finding the best study materials. So what are you waiting for? Sign up now and start your journey to success!',
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
            Positioned(
              top: 600,
              left: 200,
              child: AnimatedOpacity(
                opacity: opacityValue,
                duration: const Duration(seconds: 4),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Transform.rotate(
                    angle: -0.1,
                    child: Container(
                      width: 300,
                      height: 350,
                      margin: const EdgeInsets.only(
                          bottom: 10), // Adjust margin here
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(40),
                        color: getRandomColor(),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(-5, 0),
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    '#Start on your day on a positive note!',
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
                              'Good habits are as addictive as bad habits, but much more rewarding. Start your day on a positive note with our team of experts. We will help you get started on your journey to success. So what are you waiting for? Sign up now and start your journey to success!',
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
          ],
        ),
      ),
    );
  }
}
