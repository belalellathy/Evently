
import 'package:evently/apptheme.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/models/categories.dart';
import 'package:evently/models/event.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/tabs/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
class Editeventscreen extends StatefulWidget {
  const Editeventscreen({super.key});



  @override
  State<Editeventscreen> createState() => _EditeventscreenState();
}

class _EditeventscreenState extends State<Editeventscreen> {
  int currentindex=1;


  final TextEditingController _title=TextEditingController();
  final TextEditingController _description=TextEditingController();
  DateTime ?selecteddate;
  TimeOfDay ?selectedtime;
  String?_errorText_title;
  String?_errorText_date;
  String?_errorText_time;
  String?_errorText_descriptionn;
  late String eventid;
  @override
  Widget build(BuildContext context) {
      TextTheme textTheme= Theme.of(context).textTheme;
      Event event= ModalRoute.of(context)!.settings.arguments as Event;
      eventid=event.id;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:  Text(AppLocalizations.of(context)!.eventDetails, ),
        
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
            
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ClipRRect(
                    
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset("assets/tabsimages/${Category.categories[currentindex].ImageName}.png")),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: DefaultTabController(
                    length: Category.categories.length-1,
                    child: TabBar(
                      
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                      padding: EdgeInsets.zero,
                      onTap: (index) {
                        currentindex=index+1;
                        setState(() {
                          
                        });
                      } ,
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      tabs: 
                        Category.categories.skip(1)
                        .map((category)=>TabItem(categories: category,iselected:currentindex==Category.categories.indexOf(category) ,)).toList()
                    
                        
                      
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text("Title",style: textTheme.headlineMedium,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: _title,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: event.title,
                      errorText: _errorText_title,
                      prefixIcon: const Icon(
                        Icons.note_alt_rounded
                        
                      )
                    )
                  ),
                ),
                const SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text("Description",style: Apptheme.lightTheme.textTheme.headlineMedium),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    maxLines: 4,
                    controller: _description,
                    
                      decoration: InputDecoration(
                      hintText: event.description,
                      errorText: _errorText_descriptionn,
                      
                      
                    ),
                  ),
                ),
                
                
                
                const SizedBox(height: 16,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          const Icon(Icons.date_range_sharp),
                          const SizedBox(width: 10,),
                          Text("Event Date",style: textTheme.headlineMedium),
                          const Spacer(),
                          InkWell(
                            onTap: ()async{
                              DateTime?date=await showDatePicker(context: context,
                                firstDate: DateTime.now(), 
                                lastDate: DateTime.now().add(const Duration(days: 365)),
                                initialEntryMode: DatePickerEntryMode.calendarOnly,
                                
                                );
                                selecteddate=date;
                                _errorText_date=null;
                                setState(() {
                                  
                                });
                                                              
                            },
                            child:selecteddate!=null? Text("${selecteddate!.day}/${selecteddate!.month}/${selecteddate!.year}",style: textTheme.headlineMedium?.copyWith(color:Apptheme.blue ),):
                            Text("${event.date.day}/${event.date.month}/${event.date.year}",style: textTheme.headlineMedium?.copyWith(color:Apptheme.blue ) ,))
                      
                        ],
                      ),
                    ),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _errorText_date!=null?Text("$_errorText_date",style: textTheme.bodySmall?.copyWith(color:Colors.red),
                    textAlign: TextAlign.right,):null,)
                  ],
                ),
                const SizedBox(height: 16,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:  16.0),
                      child: Row(
                        children: [
                          const Icon(Icons.timer_sharp),
                          const SizedBox(width: 10,),
                          Text("Event Time",style: textTheme.headlineMedium),
                          const Spacer(),
                          InkWell(
                            onTap: ()async {
                            TimeOfDay?timeOfDay= await showTimePicker(context: context, 
                              initialTime: TimeOfDay.now(),
                              );
                              if(timeOfDay!=null){
                                selectedtime=timeOfDay;
                                _errorText_time=null;
                                setState(() {
                                  
                                });
                              }else{
                                _errorText_time="please pick time";
                                setState(() {
                                  
                                });
                              }
                            },
                            child:selectedtime!=null? Text(selectedtime!.format(context),style: textTheme.headlineMedium?.copyWith(color:Apptheme.blue )): Text("${event.date.hour}:${event.date.minute}",style: textTheme.headlineMedium?.copyWith(color:Apptheme.blue ) ,))
                      
                        ],
                      ),
                    ),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _errorText_time!=null?Text("$_errorText_time",style: textTheme.bodySmall?.copyWith(color:Colors.red),
                    textAlign: TextAlign.right,):null,)
                  ],
                ),
                const SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:_validatteinput,
                      
                        
                        style: ElevatedButton.styleFrom(
                          
                          backgroundColor:Apptheme.blue,
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)
                          )
                          
                        
                          
                        ), child: const Text("Edit Event",style:TextStyle(
                          
                          fontSize: 20,
                          color: Colors.white
                        ),
                        )
                        
                        ),
                  ),
                ),

              ],
            ),
          ),
        ),
        

    )
    );
  }
  void _validatteinput(){
    setState(() {
      _errorText_descriptionn=_description.text.isEmpty?"Description can't be empty":null;
      _errorText_title=_title.text.isEmpty?"Title can't be empty":null;
      _errorText_date=selecteddate==null?"please pick date":null;
      _errorText_time=selectedtime==null?"please pick time":null;
    });
    if(selecteddate!=null&&selectedtime!=null&&_errorText_title==null&&_errorText_descriptionn==null){
      DateTime dateTime=DateTime(selecteddate!.year,selecteddate!.month,selecteddate!.day,selectedtime!.hour,selectedtime!.minute);
      Event newevent=Event(
         userid: Provider.of<UserProvider>(context,listen: false).currentuser!.id,
        id:eventid, title: _title.text,category: Category.categories[currentindex],date: dateTime,description: _description.text);
      FirebaseService.overwriteEvent(newevent).then((_) {
        Navigator.of(context).pushNamed("mainscreen");
      },).catchError((_){
        print("failed");
      });
      
    }
  }
}