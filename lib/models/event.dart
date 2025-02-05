import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/categories.dart';
import 'package:flutter/material.dart';

class Event {
  String id;
  String title;
  String description;
  DateTime date;
  TimeOfDay time;
  Category category;
  Event({
  this.id="",
  required this.title,
  required this.description,
  required this.date,
  required this.time,
  required this.category});
  Map <String,dynamic> toJson()=>{
  "id": id,
  "title":title,
  "description":description,
  "category":category,
  "date":Timestamp.fromDate(date),
  

  

};
  
}
