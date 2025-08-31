import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/apptheme.dart';
import 'package:evently/models/event.dart';
import 'package:evently/providers/settings_provide.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
 import 'package:url_launcher/url_launcher.dart';

class Eventdetails extends StatefulWidget {
  const Eventdetails({super.key});

  @override
  State<Eventdetails> createState() => _EventdetailsState();
}

class _EventdetailsState extends State<Eventdetails> {
  @override
  Widget build(BuildContext context) {
    SettingsProvide settingsProvider=Provider.of<SettingsProvide>(context);
    UserProvider userProvider=Provider.of<UserProvider>(context);
    
    TextTheme textTheme= Theme.of(context).textTheme;
    Event event= ModalRoute.of(context)!.settings.arguments as Event;
    return Scaffold(
      appBar: AppBar(
          title: const Text("Event Details", ),
        
          actions: userProvider.currentuser!.id==event.userid ? [
            IconButton(onPressed: (){
              Navigator.of(context).pushNamed("Edit Event",
        arguments: event);

            },
            icon: const Icon(Icons.edit)),
            IconButton(onPressed: (){
              FirebaseFirestore.instance.collection('events').doc(event.id).delete();
              Navigator.of(context).pushNamed("mainscreen");
            
              setState(() {
                
              });
            }, 
            icon: const Icon(Icons.delete),color: Colors.red,)
          ]:null,
        
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset("assets/tabsimages/${event.category.ImageName}.png"),
              ),
              const SizedBox(height: 16,),
              Text(event.title,style:textTheme.titleLarge?.copyWith(color: Apptheme.blue) ,textAlign: TextAlign.center,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Apptheme.blue),
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Apptheme.blue,
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.calendar_month_rounded,color: Apptheme.white,),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(DateFormat('d MMMM yyyy').format(event.date),style: textTheme.bodyMedium?.copyWith(color: Apptheme.blue,fontWeight: FontWeight.w500) ,),
                          Text("${event.date.hour}:${event.date.minute}",style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500,color:settingsProvider.isDark?Apptheme.white :Apptheme.black ),)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16,),
              Text("Description",style: textTheme.headlineMedium,),
              Text(event.description,style: textTheme.bodyLarge?.copyWith(color: settingsProvider.isDark?Apptheme.white :Apptheme.black),),
              const SizedBox(height: 16,),
              Text("Location",style: textTheme.headlineMedium,),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Apptheme.blue),
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Apptheme.blue,
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.my_location_sharp,color: settingsProvider.isDark ? Apptheme.black : Apptheme.white,),
                        ),
                      ),
                      SizedBox(width: 10,),

                    InkWell(
                      onTap: () {
                        openMaps(event.location);
                      },
                      child: Text(event.location, style: textTheme.bodyLarge?.copyWith(color: settingsProvider.isDark ? Apptheme.white : Apptheme.black),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
    );
  }

  Future<void> openMaps(String location) async {
  final Uri url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(location)}');

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}
}