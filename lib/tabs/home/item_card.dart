import 'package:evently/apptheme.dart';

import 'package:evently/models/event.dart';
import 'package:evently/providers/settings_provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
Event event;
ItemCard(this.event, {super.key});

  @override
  Widget build(BuildContext context) {
    SettingsProvide settingsProvider=Provider.of<SettingsProvide>(context);
    
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed("Eventdetails",
        arguments: event);
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset("assets/tabsimages/${event.category.ImageName}.png")),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,top: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color:settingsProvider.isDark? Apptheme.primarydark: Apptheme.white,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(
                      children: [
                        Text("${event.date.day}",style:const TextStyle(
                          color: Apptheme.blue
                        ),),
                        Text(DateFormat('MMM').format(event.date),style:const TextStyle(
                          color: Apptheme.blue
                        ),)
                      ],
                    ),
                  ),
                ),
                
                Positioned(
                  bottom: 10,
                  left: 5,
                  right: 5,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration:BoxDecoration(
                      color:settingsProvider.isDark ?Apptheme.primarydark : Apptheme.white,
                      borderRadius: BorderRadius.circular(8)
                    ), 
                    child: Row(
                      children: [
                        Text(event.title,style:  TextStyle(
                          color: settingsProvider.isDark?Apptheme.white : Apptheme.black
                        ),
                        ),
                        const Spacer(),
                        SvgPicture.asset("assets/Svg/Heart.svg",colorFilter: settingsProvider.isDark? ColorFilter.mode(Apptheme.white, BlendMode.srcIn):const ColorFilter.mode(Colors.black, BlendMode.srcIn) ,)
                    
                      ],
                    ),
                  ),
                )
          
          
            ],
          ),
        ),
      
      ),
    );
  }
}