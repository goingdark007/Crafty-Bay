import 'package:flutter/material.dart';

class MainNavProvider extends ChangeNotifier {

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void backToHome(){
    _currentIndex = 0;
    notifyListeners();
  }

  void moveToCategory(){
    _currentIndex = 1;
    notifyListeners();
  }

}