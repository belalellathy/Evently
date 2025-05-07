import 'package:flutter/material.dart';

class SettingsProvide with ChangeNotifier{
  ThemeMode themeMode= ThemeMode.system;
  String lang_code='en';

  bool get isDark{if (themeMode == ThemeMode.system) {
    // Check the system brightness (requires BuildContext)
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    return brightness == Brightness.dark;
  }
  return themeMode == ThemeMode.dark;}
 
  void changetheme(ThemeMode theme){
  themeMode=theme;
  notifyListeners();
}

void changelanguage(String language){
lang_code=language;
notifyListeners();
}
}
