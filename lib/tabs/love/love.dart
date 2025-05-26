import 'package:evently/models/event.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/settings_provide.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/tabs/home/item_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Love extends StatefulWidget {
   const Love({super.key});



  @override
  State<Love> createState() => _LoveState();
}

class _LoveState extends State<Love> {
   List<int> searchresultindex = [];
     List< Event>? event;
     bool searching = false;

  @override
  Widget build(BuildContext context) {
    EventProvider eventProvider= Provider.of<EventProvider>(context);
    SettingsProvide settingsProvider=Provider.of<SettingsProvide>(context);
   event=eventProvider.fav;
     if (!searching && event != null) {
      searchresultindex = List.generate(event!.length, (index) => index);
    }

    List<String> favid = Provider.of<UserProvider>(context,listen: false).currentuser!.favEvents;
    eventProvider.addtofav(favid);
    return Column(
      children: [
        TextField(
          style: TextStyle(color: settingsProvider.isDark ? Colors.white : Colors.black),
          decoration: InputDecoration(
            
            prefixIcon: const Icon(Icons.search),
            hintText: "Search",
            
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
           
          ),
          onChanged: (value) {
            search(value);
            
            
        
          },
        ),
        SizedBox(height: 10,),
        //Text("data",style:TextStyle(color: Colors.white),),
        Expanded(child:searchresultindex.isEmpty? Center(child: Text("No event found",style: TextStyle(color:settingsProvider.isDark? Colors.white:Colors.black),)): ListView.separated(itemBuilder: (_,index)=>ItemCard(event![searchresultindex[index]]), 
        separatorBuilder:(_,__)=> const Divider(color: Colors.transparent,), 
        itemCount: eventProvider.fav.length),
       
        )
      ],
    );
  }

 void search(String value) {
  setState(() {
    searchresultindex.clear();
    if (value.isEmpty) {
      searching = false;
    } else {
      searching = true;
      for (int i = 0; i < event!.length; i++) {
        if (event![i].title.toLowerCase().contains(value.toLowerCase())) {
          searchresultindex.add(i);
        }
      }
    }
  });
}
}