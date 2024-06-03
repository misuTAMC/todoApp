// Import các thư viện cần thiết
import 'dart:async';

import 'package:flutter/material.dart';

// Lớp TimeProvider kế thừa từ ChangeNotifier để cung cấp khả năng thông báo thay đổi đến các widget lắng nghe
class TimeProvider extends ChangeNotifier {
  // Khai báo biến timer
  late Timer timer;
  // Khai báo thời gian hiện tại và thời gian đã chọn, mặc định là 1500 giây
  double currentDuration = 1500;
  double selectedTime = 1500;
  // Biến kiểm tra xem timer có đang chạy hay không
  bool timePlaying = false;

  // Hàm chọn thời gian
  void selectTime(double seconds) {
    // Cập nhật thời gian đã chọn và thời gian hiện tại
    selectedTime = seconds;
    currentDuration = seconds;
    // Thông báo đến các widget lắng nghe về sự thay đổi
    notifyListeners();
  }

  // Hàm bắt đầu timer
  void startTimer() {
    // Đặt biến timePlaying thành true để biết timer đang chạy
    timePlaying = true;
    // Khởi tạo timer chạy sau mỗi 1 giây
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Giảm thời gian hiện tại đi 1
      currentDuration--;
      // Thông báo đến các widget lắng nghe về sự thay đổi
      notifyListeners();
      // Nếu thời gian hiện tại <= 0, tạm dừng timer
      if (currentDuration <= 0) {
        pauseTimer();
      }
    });
  }

  // Hàm tạm dừng timer
  void pauseTimer() {
    // Đặt biến timePlaying thành false để biết timer đã dừng
    timePlaying = false;
    // Hủy timer
    timer.cancel();
    // Thông báo đến các widget lắng nghe về sự thay đổi
    notifyListeners();
  }
}
