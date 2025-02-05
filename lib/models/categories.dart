import 'package:flutter/material.dart';

class Category{
  String id;
  String name;
  IconData Icon;
  String ImageName;
  Category({
    required this.id,
    required this.name,
    required this.Icon,
    required this.ImageName,
  });
  static List<Category>categories=[
    Category(id: "1", name: "sports", Icon: Icons.sports_motorsports_sharp, ImageName: "sport"),
    Category(id: "2", name: "Birthday", Icon:Icons.cake, ImageName: "birthday"),
    Category(id: "3", name: "Meeting", Icon: Icons.laptop, ImageName: "meeting"),
    Category(id: "4", name: "Gaming", Icon: Icons.gamepad, ImageName: "gaming"),
    Category(id: "5", name: "Eating", Icon: Icons.fastfood_outlined, ImageName: "eating"),
    Category(id: "6", name: "Holiday", Icon: Icons.pool, ImageName: "holiday"),
    Category(id: "7", name: "Exhibition", Icon: Icons.punch_clock_outlined, ImageName: "exhibition"),
    Category(id: "8", name: "WorkShop", Icon: Icons.work_history, ImageName: "workshop"),
    Category(id: "9", name: "BookClub", Icon: Icons.book, ImageName: "bookclub"),


  ];

}