import 'package:evently/apptheme.dart';
import 'package:evently/models/categories.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/tabs/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int currentindex=0;
  @override
  Widget build(BuildContext context) {
    EventProvider eventProvider=Provider.of<EventProvider>(context);
    TextTheme textTheme= Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height*0.2,
      decoration: const BoxDecoration(
        color: Apptheme.blue,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16),bottomRight: Radius.circular(16))

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Welcome back",style: textTheme.bodyMedium?.copyWith(color: Apptheme.white),),
          const Spacer(),
            DefaultTabController(
                    length: Category.categories.length,
                    child: TabBar(
                      
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                      padding: EdgeInsets.zero,
                      onTap: (index) {
                        currentindex=index;
                        eventProvider.changeselectedcategory(Category.categories[index]);
                    
                        
                      } ,
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      tabs: 
                        Category.categories.map((category)=>TabItem(categories: category,iselected:currentindex==Category.categories.indexOf(category) ,)).toList()
                    
                        
                      
                    ),
                  ),
          
        ],
      ),
    );
  }
}