import 'package:evently/apptheme.dart';
import 'package:evently/models/categories.dart';

import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  bool iselected;
TabItem({super.key, required this.categories,required this.iselected});
Category categories;
  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
        color:iselected? Apptheme.blue: Apptheme.white,
        border: Border.all(width: 1,color: Apptheme.blue),
        borderRadius: BorderRadius.circular(46)),
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
      child:Row(
        children: [
          Icon((categories.Icon)),
          const SizedBox(width: 8,),
          Text(categories.name)
        ],
      ) ,
    );
  }
}