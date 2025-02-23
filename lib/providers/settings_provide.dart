import 'package:flutter/material.dart';

class SettingsProvide with ChangeNotifier{
  ThemeMode themeMode= ThemeMode.light;
  String lang_code='ar';
  bool get isDark=>themeMode==ThemeMode.dark;
  void changetheme(ThemeMode theme){
  themeMode=theme;
  notifyListeners();
}

void changelanguage(String language){
lang_code=language;
notifyListeners();
}
}
