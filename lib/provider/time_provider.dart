import 'dart:async';

import 'package:flutter/material.dart';



class TimeProvider extends ChangeNotifier {
  late Timer timer;
  double currentDuration = 1500;
  double selectedTime = 1500;
  bool timePlaying = false;
  void selectTime(double secconds) {
    selectedTime = secconds;
    currentDuration = secconds;
    notifyListeners();
  }

  void startTimer() {

    timePlaying = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      currentDuration--;
      notifyListeners();
      if (currentDuration <= 0) {
        pauseTimer();
      }
    });
  }

  void pauseTimer() {
    timePlaying = false;
    timer.cancel();
    notifyListeners();
  }
}
