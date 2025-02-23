import 'package:flutter/material.dart';

class Apptheme {
  static const Color primarydark=Color(0xff101127);
  static const Color blue=Color(0xff5669FF);
  static const Color black=Colors.black;
  static const Color white=Colors.white;

  static ThemeData darkTheme =ThemeData(
        tabBarTheme: const TabBarTheme(
      
      labelColor: white,
      
      unselectedLabelStyle: TextStyle(
        fontSize: 16,
        
        fontWeight: FontWeight.w700

      ),
      
      unselectedLabelColor: primarydark,
      labelStyle: TextStyle(
        fontSize: 16,
        
        fontWeight: FontWeight.w700
      )
    ),
      inputDecorationTheme: InputDecorationTheme(
        
      hintStyle: const TextStyle(
        color: white,
        fontSize: 14,
        fontWeight: FontWeight.w500
      ),
      border:OutlineInputBorder(borderRadius: BorderRadius.circular(16),borderSide: const BorderSide(width: 1,
      color:blue )) ,
      enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(16),borderSide: const BorderSide(width: 1,
      color:blue )) 
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: white

      )
    ),
    scaffoldBackgroundColor:primarydark,
    appBarTheme: const AppBarTheme(
      
      backgroundColor:primarydark,
      foregroundColor: blue,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 22,
        
        color: blue
      )
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor:primarydark ,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedLabelStyle: TextStyle(
      color: white
      ),
      selectedLabelStyle: TextStyle(
      color: white
      ),
      selectedItemColor: white,
      unselectedItemColor: white
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primarydark,
      foregroundColor: white,
      shape: CircleBorder(side: BorderSide(width: 5,color: white))
    )
    );
  static ThemeData lightTheme =ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor:white,
      foregroundColor:blue,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 22,
        color: blue
      )
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor:blue ,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedLabelStyle: TextStyle(
      color: white
      
      ),
      selectedLabelStyle: TextStyle(
      color: white
      ),
      selectedItemColor: white,
      unselectedItemColor: white
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor:blue,
      foregroundColor: white,
      shape: CircleBorder(side: BorderSide(width: 5,color: white))
    ),
    tabBarTheme: const TabBarTheme(
      
      labelColor: white,
      unselectedLabelStyle: TextStyle(
        fontSize: 16,
        
        fontWeight: FontWeight.w700

      ),
      
      unselectedLabelColor: blue,
      labelStyle: TextStyle(
        fontSize: 16,
        
        fontWeight: FontWeight.w700
      )
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: black

      ),
      
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(
        color: Color(0xff7B7B7B),
        fontSize: 14,
        fontWeight: FontWeight.w500
      ),
      border:OutlineInputBorder(borderRadius: BorderRadius.circular(16),borderSide: const BorderSide(width: 1,
      color:Color(0xff7B7B7B) )) ,
      enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(16),borderSide: const BorderSide(width: 1,
      color:Color(0xff7B7B7B) )) 
    )
  );
  
}