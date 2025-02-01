import 'package:flutter/material.dart';

class Apptheme {
  static const Color primarydark=Color(0xff101127);
  static const Color blue=Color(0xff5669FF);
  static const Color black=Colors.black;
  static const Color white=Colors.white;
  static ThemeData darkTheme =ThemeData(
    scaffoldBackgroundColor:primarydark,
    appBarTheme: const AppBarTheme(
      backgroundColor:primarydark,
      foregroundColor:white,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: white
      )
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      
      backgroundColor:primarydark ,
      showSelectedLabels: true,
      showUnselectedLabels: true,
     selectedItemColor: white,
     unselectedItemColor: white,
     unselectedLabelStyle: TextStyle(
      color: white
     ),
     selectedLabelStyle: TextStyle(
      color: white
     )
    ));
  static ThemeData lightTheme =ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor:blue,
      foregroundColor:white,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: white
      )
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor:blue ,
      showSelectedLabels: true,
      showUnselectedLabels: true,
     selectedItemColor: white,
     

     unselectedLabelStyle: TextStyle(
      color: white
      
     ),
      selectedLabelStyle: TextStyle(
      color: white
     )
    )
  );
  
}