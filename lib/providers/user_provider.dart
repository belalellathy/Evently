import 'package:evently/models/usermodel.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  Usermodel?currentuser;
  void UpdateCurrentUser(Usermodel? user){
    currentuser=user;
    notifyListeners();
  }
}