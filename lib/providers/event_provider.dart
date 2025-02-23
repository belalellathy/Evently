import 'package:evently/firebase_service.dart';
import 'package:evently/models/categories.dart';
import 'package:evently/models/event.dart';
import 'package:flutter/material.dart';

class EventProvider with ChangeNotifier{
  List<Event>events=[];
  Category? selectedcategory;
  Future<void>getevents()async{
    events= await FirebaseService.geteventsfromfirestor(selectedcategory?.id);
    events.sort(
      (event, nextevent) =>event.date.compareTo(nextevent.date) ,
    );
    notifyListeners();
  }
  void changeselectedcategory(Category category){
    selectedcategory=category;
    getevents();
    

  }
}