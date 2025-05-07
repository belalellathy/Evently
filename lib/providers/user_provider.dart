import 'package:evently/models/usermodel.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  Usermodel?currentuser;
  void UpdateCurrentUser(Usermodel? user){
    currentuser=user;
    notifyListeners();
  }
  void addeventtofav(String eventid){
    currentuser!.favEvents.add(eventid);
    notifyListeners();
  }
  void removeeventfromfav(String eventid){
    currentuser!.favEvents.remove(eventid);
    notifyListeners();
  }
  bool checkIseventfav(String eventid){
    return currentuser!.favEvents.any((favEvents)=>favEvents==eventid);
  }
}