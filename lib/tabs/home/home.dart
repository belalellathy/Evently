import 'package:evently/apptheme.dart';
import 'package:evently/firebase_service.dart';

import 'package:evently/models/event.dart';
import 'package:evently/tabs/home/home_header.dart';
import 'package:evently/tabs/home/item_card.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Event>events=[];

  @override
  Widget build(BuildContext context) {
    if(events.isEmpty){
      getevents();
    }
    
   
    return Column(children: [
      const HomeHeader(),
      const SizedBox(height: 16,),
      Expanded(
        child: ListView.separated(
          itemBuilder: (_,index)=>ItemCard(events[index]), 
          separatorBuilder:(_,__)=> const Divider(color: Colors.transparent,), 
          itemCount: events.length),
      )
      
    ],)
    ;
  }
  Future<void>getevents()async{
    events= await FirebaseService.geteventsfromfirestor();
    setState(() {
      
    });

  }
}