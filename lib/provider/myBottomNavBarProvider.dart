import 'package:flutter/material.dart';

class Mybottomnavbarprovider extends ChangeNotifier{
  int currentIndex;
  Mybottomnavbarprovider({required this.currentIndex});

   int get value => currentIndex; // Getter for the value

  void  setvalue(int newValue) {
    currentIndex = newValue;
    notifyListeners(); // Notify listeners when the value changes
  }
}