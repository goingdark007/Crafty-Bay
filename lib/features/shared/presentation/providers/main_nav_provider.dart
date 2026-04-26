import 'package:flutter/material.dart';

class MainNavProvider extends ChangeNotifier {

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  Future<void> changeIndex(int index) async {

    _currentIndex = index;
    notifyListeners();
  }

  bool shouldCheckUserLoggedIn(int index) => index == 2 || index == 3;

  void backToHome(){
    _currentIndex = 0;
    notifyListeners();
  }

  void moveToCategory(){
    _currentIndex = 1;
    notifyListeners();
  }

}