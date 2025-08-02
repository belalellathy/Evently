import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  Usermodel?currentuser;

bool isLoggedIn=false;
  var user = FirebaseAuth.instance.currentUser;
  Future<void> autologin() async {
    if (user != null) {
      CollectionReference<Usermodel> userscollection = FirebaseService.getuserscollection();
      DocumentSnapshot<Usermodel> usersnapshot = await userscollection.doc(user!.uid).get();


      if (usersnapshot.exists) {
       
        currentuser = usersnapshot.data();
        isLoggedIn = true;
      }
    }
  }

  
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