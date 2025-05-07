import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/tabs/home/item_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Love extends StatelessWidget {
  const Love({super.key});

  

  @override
  Widget build(BuildContext context) {
    EventProvider eventProvider= Provider.of<EventProvider>(context);

    List<String> favid = Provider.of<UserProvider>(context,listen: false).currentuser!.favEvents;
    eventProvider.addtofav(favid);
    return Column(
      children: [
        //Text("data",style:TextStyle(color: Colors.white),),
        Expanded(child: ListView.separated(itemBuilder: (_,index)=>ItemCard(eventProvider.fav[index]), 
        separatorBuilder:(_,__)=> const Divider(color: Colors.transparent,), 
        itemCount: eventProvider.fav.length),
        ),
      ],
    );
  }
}