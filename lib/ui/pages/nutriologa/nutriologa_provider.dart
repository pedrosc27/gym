import 'package:flutter/material.dart';

class NutriologaProvider extends ChangeNotifier {
  String user = "";

  void setUser(String userEmail) {
    user = userEmail;
    notifyListeners();
  }


}
