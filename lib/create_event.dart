
import 'package:evently/apptheme.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/models/categories.dart';
import 'package:evently/models/event.dart';
import 'package:evently/providers/settings_provide.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/tabs/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});



  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  int currentindex=1;


  final TextEditingController _title=TextEditingController();
  final TextEditingController _description=TextEditingController();
  DateTime ?selecteddate;
  TimeOfDay ?selectedtime;
  String?_errorText_title;
  String?_errorText_date;
  String?_errorText_time;
  String?_errorText_descriptionn;
  @override
  Widget build(BuildContext context) {
    SettingsProvide settingsProvider=Provider.of<SettingsProvide>(context);
      TextTheme textTheme= Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create Event", ),
        
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
                        Category.categories.skip(1).
                        map((category)=>TabItem(categories: category,iselected:currentindex==Category.categories.indexOf(category) ,
                      )
                        ).toList()
                    
                        
                      
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
                    style: TextStyle(color: settingsProvider.isDark?Apptheme.white:Apptheme.black),
                    controller: _title,
                       onTapOutside: (_) =>FocusManager.instance.primaryFocus?.unfocus(),
                    decoration: InputDecoration(
                      hintText: "Event Title",
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
                  child: Text("Description",style: Apptheme.lightTheme.textTheme.headlineMedium?.copyWith(color:settingsProvider.isDark ? Apptheme.white:Apptheme.black)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    style: TextStyle(color: settingsProvider.isDark?Apptheme.white:Apptheme.black),
                    maxLines: 4,
                    controller: _description,
                    onTapOutside: (_) =>FocusManager.instance.primaryFocus?.unfocus() ,
                      decoration: InputDecoration(
                      hintText: "Event Description",
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
                           Icon(Icons.date_range_sharp,color: settingsProvider.isDark?Apptheme.white :Apptheme.black,),
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
                                if(date!=null){
                                  selecteddate=date;
                                  _errorText_date=null;
                                  setState(() {
                                    
                                  });
                                }else{
                                  _errorText_date="please choose date";
                                }
                                
                            },
                            child:selecteddate!=null? Text("${selecteddate!.day}/${selecteddate!.month}/${selecteddate!.year}",style: textTheme.headlineMedium?.copyWith(color:Apptheme.blue ),):
                             Text("Choose date",style: textTheme.headlineMedium?.copyWith(color:Apptheme.blue ) ,))
                      
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
                          Icon(Icons.timer_sharp,color: settingsProvider.isDark?Apptheme.white :Apptheme.black,),
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
                            child:selectedtime!=null? Text(selectedtime!.format(context),style: textTheme.headlineMedium?.copyWith(color:Apptheme.blue )): Text("Choose Time",style: textTheme.headlineMedium?.copyWith(color:Apptheme.blue ) ,))
                      
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
                          
                        
                          
                        ), child: const Text("Add Event",style:TextStyle(
                          
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
        title: _title.text,category: Category.categories[currentindex],date: dateTime,description: _description.text);
      FirebaseService.addEventToFirestore(newevent).then((_) {
        Navigator.of(context).pop();
      },).catchError((_){
        print("failed");
      });
    }
    
  }
}