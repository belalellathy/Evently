import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvide with ChangeNotifier{
  ThemeMode themeMode= ThemeMode.system;
  String lang_code='en';

  bool get isDark{if (themeMode == ThemeMode.system) {
    // Check the system brightness (requires BuildContext)
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    return brightness == Brightness.dark;
  }
  return themeMode == ThemeMode.dark;}
 
  Future <void> changetheme(ThemeMode theme)async{
    themeMode=theme;
  SharedPreferences pref=await SharedPreferences.getInstance();
  await pref.setString('theme', theme.toString());
  notifyListeners();
}

Future <void> changelanguage(String language)async{
lang_code=language;
SharedPreferences pref=await SharedPreferences.getInstance() ;
 await pref.setString('lang', language);

notifyListeners();
}
  Future<void> loadSettings() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? savedTheme = pref.getString('theme');
    String? savedLang = pref.getString('lang');

    if (savedTheme != null) {
      if (savedTheme == ThemeMode.light.toString()) {
        themeMode = ThemeMode.light;
      } else if (savedTheme == ThemeMode.dark.toString()) {
        themeMode = ThemeMode.dark;
      } else {
        themeMode = ThemeMode.system;
      }
    }

    if (savedLang != null) {
      lang_code = savedLang;
    }

    notifyListeners();
  }
  
}
