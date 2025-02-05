

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/categories.dart';


class Event {
  String id;
  String title;
  String description;
  DateTime date;

  Category category;
  Event({
  this.id="",
  required this.title,
  required this.description,
  required this.date,
  required this.category});
  Event.forJson(Map <String,dynamic> Json):this(
    id:Json["id"] ,
    title:Json["title"] ,
    description:Json["description"] ,
    date:(Json["date"]as Timestamp).toDate() ,
    category:Category.categories.firstWhere((Category)=>Category.id==Json["categoryID"])
    );
  Map <String,dynamic> toJson()=>{
  "id": id,
  "title":title,
  "description":description,
  "categoryID":category.id,
  "date":Timestamp.fromDate(date),
};

  
}
