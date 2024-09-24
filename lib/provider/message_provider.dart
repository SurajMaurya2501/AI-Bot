import 'package:flutter/material.dart';

class MessageProvider extends ChangeNotifier {

  void updateWidget() {
    notifyListeners();
  }

}
