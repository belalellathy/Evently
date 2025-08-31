import 'package:evently/firebase_service.dart';
import 'package:evently/models/categories.dart';
import 'package:evently/models/event.dart';
import 'package:flutter/material.dart';

class EventProvider with ChangeNotifier{
  List<Event>events=[];
  List<Event>fav=[];
  Category? selectedcategory;
  Future<void>getevents()async{
    events= await FirebaseService.geteventsfromfirestor(selectedcategory?.id);
    if(events.isNotEmpty){
       events.sort(
      (event, nextevent) =>event.date.compareTo(nextevent.date) ,
    );
    }
    else{
      events=[];
    }

    notifyListeners();
  }
  void changeselectedcategory(Category category){
    selectedcategory=category;
    getevents();
    

  }
  Future<void> addToFavtofirestore (String eventid)async{
    await FirebaseService.addToFav(eventid);
    notifyListeners();
  }
  Future<void> removeFromFav (String eventid)async{
    await FirebaseService.removeFromFav(eventid);
    notifyListeners();
  }
  void addtofav(List<String>favid){
    fav=events.where((event) => favid.contains(event.id)).toList();
    getevents();
  
  }
}