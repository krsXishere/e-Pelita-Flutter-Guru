import 'package:flutter/material.dart';

class NavigationBarProvider with ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  updateCurrentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  } 
}