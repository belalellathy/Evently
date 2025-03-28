import 'package:evently/apptheme.dart';
import 'package:evently/models/categories.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/settings_provide.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/tabs/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {

  int currentindex=0;
  @override
  Widget build(BuildContext context) {
      SettingsProvide settingsProvider=Provider.of<SettingsProvide>(context);
    EventProvider eventProvider=Provider.of<EventProvider>(context);
    TextTheme textTheme= Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height*0.2,
      decoration:  BoxDecoration(
        color:settingsProvider.isDark?Apptheme.primarydark : Apptheme.blue,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16))

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(AppLocalizations.of(context)!.welcomeBack,style: textTheme.headlineMedium?.copyWith(color: Apptheme.white),),
          Text(Provider.of<UserProvider>(context,listen: false).currentuser!.name,style: textTheme.headlineLarge?.copyWith(color: Apptheme.white),),
          const Spacer(),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: DefaultTabController(
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
            ),
          
        ],
      ),
    );
  }
}