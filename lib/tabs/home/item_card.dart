import 'package:evently/apptheme.dart';

import 'package:evently/models/event.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/settings_provide.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatefulWidget {
Event event;
ItemCard(this.event, {super.key});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    bool isfav=Provider.of<UserProvider>(context).checkIseventfav(widget.event.id);
    SettingsProvide settingsProvider=Provider.of<SettingsProvide>(context);
    
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed("Eventdetails",
        arguments: widget.event);
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset("assets/tabsimages/${widget.event.category.ImageName}.png")),
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
                        Text("${widget.event.date.day}",style:const TextStyle(
                          color: Apptheme.blue
                        ),),
                        Text(DateFormat('MMM').format(widget.event.date),style:const TextStyle(
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
                        Text(widget.event.title,style:  TextStyle(
                          color: settingsProvider.isDark?Apptheme.white : Apptheme.black
                        ),
                        ),
                        const Spacer(),
                        IconButton(onPressed: (){
                          if(isfav){
                          Provider.of<UserProvider>(context,listen: false).removeeventfromfav(widget.event.id); 
                          Provider.of< EventProvider >(context,listen: false).removeFromFav(widget.event.id);
                          }else{
                          Provider.of<UserProvider>(context,listen: false).addeventtofav(widget.event.id);
                          Provider.of< EventProvider >(context,listen: false).addToFavtofirestore(widget.event.id);
                          }
                          setState(() {
                            
                          });
                        }, icon:isfav? Icon(Icons.favorite,color: settingsProvider.isDark?Apptheme.white : Apptheme.blue): SvgPicture.asset("assets/Svg/Heart.svg",colorFilter: settingsProvider.isDark? ColorFilter.mode(Apptheme.white, BlendMode.srcIn):const ColorFilter.mode(Apptheme.blue, BlendMode.srcIn),))
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