import 'package:evently/apptheme.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/providers/settings_provide.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Profile extends StatelessWidget {
    Profile({super.key});
  List<language>languagecode=[
    language(code: "en", name: "English"),
    language(code: "ar", name: "Arabic"),
  ];

  @override
  Widget build(BuildContext context) {
    SettingsProvide settingsProvider=Provider.of<SettingsProvide>(context);
    TextTheme textTheme= Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height*0.2,
          decoration: const BoxDecoration(
            color: Apptheme.blue,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(64))
        
          ),
          child: Row(
            
            
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: CircleAvatar(
                    radius: 50,
                    child: Image.asset("assets/images/Rectangle 76.png")),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(Provider.of<UserProvider>(context,listen: false).currentuser!.name,style: textTheme.headlineLarge?.copyWith(color: Apptheme.white),))
              ]
              )
        ),
        SizedBox(height: 24,),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(AppLocalizations.of(context)!.theme,style: textTheme.titleLarge?.copyWith(color: settingsProvider.isDark?Apptheme.white :Apptheme.black),),
            ),
            Switch(value: settingsProvider.isDark, onChanged: (value){
          if(value==true){
            settingsProvider.changetheme(ThemeMode.dark);
          }
          else{
            settingsProvider.changetheme(ThemeMode.light);
          }
        
        })
          ],
        ),
        SizedBox(height: 24,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.language,style: textTheme.titleLarge?.copyWith(color: settingsProvider.isDark?Apptheme.white :Apptheme.black)),
              DropdownButtonHideUnderline(
                child: DropdownButton(
                  value:settingsProvider.lang_code,
                  items:languagecode.map((language)=>DropdownMenuItem(
                  
                  child: Text(language.name,style:textTheme.bodyLarge?.copyWith(color: Apptheme.blue) ,),
                  value:language.code ,
                  )
                  ).toList() , onChanged: (language){
                    if(language!=null){
                    settingsProvider.changelanguage(language);
                
                    }
                    
                    
                
                  }
                  ),
              )
            ],
          ),
        ),
        
        Spacer(),
          Container(
            margin: EdgeInsets.only(bottom: 40),
            child: Padding(
              
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                
                    width: double.infinity,
                    child: ElevatedButton(onPressed: (){
                      FirebaseService.logout();
                      Provider.of<UserProvider>(context,listen: false).UpdateCurrentUser(null);
                      Navigator.of(context).pushReplacementNamed("Home");
                    }, 
                    
                    style: ElevatedButton.styleFrom(
                      
                                
                                backgroundColor:Colors.red,
                                padding: const EdgeInsets.all(16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)
                                )
                                
                              
                                
                              ), child: Row(
                                
                                children: [
                                  Icon(Icons.exit_to_app,color: Apptheme.white,),
                                  SizedBox(width: 20,),
                                   Text(AppLocalizations.of(context)!.logout,style:TextStyle(
                                    
                                    fontSize: 20,
                                    color: Colors.white
                                  ),
                                  ),
                                ],
                              )
                    
                              ),
                  ),
            ),
          ),
      
      ],
    );
  }
}
class language{
  String code;
  String name;
  language({required this.code,required this.name});
}