import 'package:flutter/material.dart';

class MyModel with ChangeNotifier {
  MyModel({this.counter = 0});

  int counter = 0;

  /*Future<void> incrementCounter() async {
    await Future.delayed(Duration(microseconds: 500));
    counter++;
    print(counter);
    notifyListeners(); // 通知ChangeNotifierProvider去重新渲染Consumer。
  }*/

  void incrementCounter() {
    counter++;
    print(counter);
    notifyListeners();
  }
}
