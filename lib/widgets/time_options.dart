// Import các thư viện cần thiết
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinhtoandidong_project/provider/time_provider.dart';

// Danh sách các thời gian có thể chọn
List selectableTimes = [
  "2",
  "10",
  "300",
  "600",
  "900",
  "1200",
  "1500",
  "1800",
  "2100",
  "2400",
  "2700",
  "3000",
  "3300",
  "3600",
  "3900",
  "4200",
  "4500",
  "4800",
  "5100",
  "5400",
  "5700",
  "6000",
  "6300",
  "6600",
  "6900",
  "7200",
];

class TimeOptions extends StatelessWidget {
  TimeOptions({super.key});

  // Hàm xây dựng UI
  @override
  Widget build(BuildContext context) {
    // Lấy đối tượng provider từ context
    final provider = Provider.of<TimeProvider>(context);

    // Trả về một widget cuộn ngang
    return SingleChildScrollView(
      // Khởi tạo vị trí cuộn ban đầu
      controller: ScrollController(initialScrollOffset: 155),
      // Đặt hướng cuộn là ngang
      scrollDirection: Axis.horizontal,
      // Tạo một hàng chứa các widget con
      child: Row(
        // Duyệt qua danh sách thời gian có thể chọn
        children: selectableTimes.map((time) {
          // Trả về một widget có thể nhấp
          return InkWell(
            // Khi nhấp, cập nhật thời gian đã chọn trong provider
            onTap: () {
              return provider.selectTime(double.parse(time));
            },
            // Tạo một container chứa text
            child: Container(
              // Đặt margin phải là 10
              margin: EdgeInsets.only(right: 10),
              // Đặt chiều rộng và chiều cao
              width: 70,
              height: 50,
              // Tạo decoration cho container
              decoration: int.parse(time) == provider.selectedTime
                  ? BoxDecoration(
                      // Nếu thời gian này đã được chọn, đặt màu nền là trắng, viền đen và có bóng
                      color: Colors.white,
                      border: Border.all(
                        width: 2,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    )
                  : BoxDecoration(
                      // Nếu thời gian này chưa được chọn, đặt màu nền là trắng, viền đen
                      color: Colors.white,
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
              // Tạo một text widget ở giữa container
              child: Center(
                child: Text(
                  // Hiển thị thời gian chia cho 60
                  '${int.parse(time) ~/ 60}',
                  // Đặt màu sắc, kích thước và độ dày cho text
                  style: TextStyle(
                    color: int.parse(time) == provider.selectedTime
                        ? Colors.black
                        : Colors.blueGrey,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          );
        }).toList(), // Chuyển đổi map sang list
      ),
    );
  }
}
