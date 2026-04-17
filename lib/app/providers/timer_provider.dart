import 'dart:async';
import 'package:flutter/material.dart';

class TimerProvider  extends ChangeNotifier {

  int _startTime = 30;
  int get startTime => _startTime;
  late Timer _resendOTPTimer;

  bool _showResetOTPButton = true;

  bool get showResetOTPButton => _showResetOTPButton;

  void startTimer () {
    _startTime = 30;
    _showResetOTPButton = false;
    _resendOTPTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_startTime == 0) {
        timer.cancel();
        _showResetOTPButton = true;
      } else {
        _startTime--;
      }
      notifyListeners();
    });
  }

  void stopTimer(){
    _resendOTPTimer.cancel();
  }

  @override
  void dispose() {
    _resendOTPTimer.cancel();
    super.dispose();
  }

}