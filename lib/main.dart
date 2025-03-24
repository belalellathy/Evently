import 'package:evently/apptheme.dart';
import 'package:evently/auth/loginScreen.dart';
import 'package:evently/auth/register.dart';
import 'package:evently/create_event.dart';
import 'package:evently/editeventscreen.dart';
import 'package:evently/eventdetails.dart';
import 'package:evently/mainscreen.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/settings_provide.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    SettingsProvide settingsProvider=Provider.of<SettingsProvide>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(settingsProvider.lang_code),
      initialRoute:"Home" ,
      routes: {
        "Home": (context)=> LoginScreen(),
        "register": (context)=> Register(),
        "mainscreen":(context)=>const Mainscreen(),
        "CreateEvent":(context)=> const CreateEvent(),
        "Eventdetails":(context)=>const Eventdetails(),
        "Edit Event":(context)=>const Editeventscreen()

      },
      theme: Apptheme.lightTheme,
      darkTheme: Apptheme.darkTheme,
      themeMode:settingsProvider.themeMode ,
    );
  }
}
