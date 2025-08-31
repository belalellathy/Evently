
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/settings_provide.dart';
import 'package:evently/tabs/home/home_header.dart';
import 'package:evently/tabs/home/item_card.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    EventProvider eventProvider= Provider.of<EventProvider>(context);
    SettingsProvide settingsProvider=Provider.of<SettingsProvide>(context);
    
      eventProvider.getevents();
    
    return Column(children: [
      const HomeHeader(),
      const SizedBox(height: 16,),
      Expanded(
        child: ListView.separated(
          itemBuilder:eventProvider.events.isEmpty ?(_,__)=> 
             Center(
              child: Text("No upcoming events", style: TextStyle(color:settingsProvider.isDark ? Colors.white : Colors.black),),  
            )
           :(_,index)=>ItemCard(eventProvider.events[index]), 
          separatorBuilder:(_,__)=> const Divider(color: Colors.transparent,), 
          itemCount: eventProvider.events.isEmpty ? 1 : eventProvider.events.length),
      )

    ],);
  }
}