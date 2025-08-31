import 'package:evently/apptheme.dart';
import 'package:evently/auth/loginScreen.dart';
import 'package:evently/auth/register.dart';
import 'package:evently/create_event.dart';
import 'package:evently/editeventscreen.dart';
import 'package:evently/eventdetails.dart';
import 'package:evently/mainscreen.dart';
import 'package:evently/models/usermodel.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/settings_provide.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evently/l10n/app_localizations.dart';
Future<void> main()async{
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
    runApp(MultiProvider(
      providers:[
        ChangeNotifierProvider(
        create: (_) => EventProvider(),
        ),
        ChangeNotifierProvider(create: (_)=>SettingsProvide()),
        ChangeNotifierProvider(create: (_)=>UserProvider())
      ] ,
      child: const RUNAPP()
    ));
}
class RUNAPP extends StatelessWidget {
  const RUNAPP({super.key});


  @override
  Widget build(BuildContext context) {
   UserProvider userProvider=Provider.of<UserProvider>(context);
   userProvider.autologin();
    Usermodel? user = userProvider.currentuser;
    
    //print( user);
    
    String initialRoute = 'splash';

    SettingsProvide settingsProvider=Provider.of<SettingsProvide>(context);
    settingsProvider.loadSettings();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(settingsProvider.lang_code),
      
      initialRoute:initialRoute ,
      routes: {
        "Home": (context)=> LoginScreen(),
        "register": (context)=> Register(),
        "mainscreen":(context)=>const Mainscreen(),
        "CreateEvent":(context)=> const CreateEvent(),
        "Eventdetails":(context)=>const Eventdetails(),
        "Edit Event":(context)=>const Editeventscreen(),
        "splash":(context)=>const SplashScreen(),

      },
      theme: Apptheme.lightTheme,
      darkTheme: Apptheme.darkTheme,
      themeMode:settingsProvider.themeMode ,
    );
  }
  
}
