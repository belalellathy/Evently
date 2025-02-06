import 'package:evently/apptheme.dart';
import 'package:evently/create_event.dart';
import 'package:evently/editeventscreen.dart';
import 'package:evently/eventdetails.dart';
import 'package:evently/login_screen.dart';
import 'package:evently/mainscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main()async{
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
    runApp(const RUNAPP());
}
class RUNAPP extends StatelessWidget {
  const RUNAPP({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:"mainscreen" ,
      routes: {
        "Home": (context)=>const Login(),
        "mainscreen":(context)=>const Mainscreen(),
        "CreateEvent":(context)=> CreateEvent(),
        "Eventdetails":(context)=>const Eventdetails(),
        "Edit Event":(context)=>const Editeventscreen()
      },
      theme: Apptheme.lightTheme,
      darkTheme: Apptheme.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
