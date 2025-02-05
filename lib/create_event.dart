
import 'package:evently/apptheme.dart';
import 'package:evently/models/categories.dart';
import 'package:evently/models/event.dart';
import 'package:evently/tabs/tab_item.dart';
import 'package:flutter/material.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});



  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  int currentindex=0;


  final TextEditingController _title=TextEditingController();
  final TextEditingController _description=TextEditingController();
  DateTime ?selecteddate;
  TimeOfDay ?selectedtime;
  String?_errorText_title;
  String?_errorText_descriptionn;
  @override
  Widget build(BuildContext context) {
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
                    length: Category.categories.length,
                    child: TabBar(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                      padding: EdgeInsets.zero,
                      onTap: (index) {
                        currentindex=index;
                        setState(() {
                          
                        });
                      } ,
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      tabs: 
                        Category.categories.map((category)=>TabItem(categories: category,iselected:currentindex==Category.categories.indexOf(category) ,)).toList()
                    
                        
                      
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
                  child: Text("Description",style: Apptheme.lightTheme.textTheme.headlineMedium),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    maxLines: 4,
                    controller: _description,
                      decoration: InputDecoration(
                      hintText: "Event Description",
                      errorText: _errorText_descriptionn,
                      
                      
                    ),
                  ),
                ),
                
                
                
                const SizedBox(height: 16,),
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
                            if(date!=null){
                              selecteddate=date;
                              setState(() {
                                
                              });
                            }
                        },
                        child:selecteddate!=null? Text("${selecteddate!.day}/${selecteddate!.month}/${selecteddate!.year}",style: textTheme.headlineMedium?.copyWith(color:Apptheme.blue ),):
                         Text("Choose date",style: textTheme.headlineMedium?.copyWith(color:Apptheme.blue ) ,))
                  
                    ],
                  ),
                ),
                const SizedBox(height: 16,),
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
                            setState(() {
                              
                            });
                          }
                        },
                        child:selectedtime!=null? Text(selectedtime!.format(context),style: textTheme.headlineMedium?.copyWith(color:Apptheme.blue )): Text("Choose Time",style: textTheme.headlineMedium?.copyWith(color:Apptheme.blue ) ,))
                  
                    ],
                  ),
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
    });
    if(selecteddate!=null&&selectedtime!=null&&_errorText_title==null&&_errorText_descriptionn==null){
      Event newevent=Event(title: _title.toString(),category: Category.categories[currentindex],date: selecteddate!,time: selectedtime!,description: _description.toString());
      print("succefyl");
      print(newevent.category.name);
    }
    else{
      print("Failed");
      return;
    }
  }
}