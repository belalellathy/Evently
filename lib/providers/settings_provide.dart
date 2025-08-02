import 'dart:ffi';

import 'package:evently/models/event.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart'as geocoding;

class SettingsProvide with ChangeNotifier{
  Location location = Location();
  late GoogleMapController mapController;
  ThemeMode themeMode= ThemeMode.system;
  String lang_code='en';
  bool shouldfollowuser = false;
  LatLng ? eventlocation ;
  String? eventlocationname;
  
 
  late LocationData locationData;  
   String city="Loading...";
   String country="Loading...";

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
Future<void>getlocation()async{
  
  bool isEnabled = await checklocationenabled();
  if (isEnabled) {
    locationData = await location.getLocation();
   }
  notifyListeners();

}
Future<void>getlocationname()async{
  locationData = await location.getLocation();
   List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(
      locationData.latitude ?? 0,
      locationData.longitude ?? 0,
    );
    if (placemarks.isNotEmpty) {
      geocoding.Placemark place = placemarks.first;
      city = place.subAdministrativeArea ?? '';
      country = place.country ?? '';
     

    }
}
  Future<bool> checklocationenabled()async{

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;


  }
  Future<void> changeeventlocation(LatLng location)async{
    eventlocation=location;
    List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(
      locationData.latitude ?? 0,
      locationData.longitude ?? 0,
    );
    if (placemarks.isNotEmpty) {
      geocoding.Placemark place = placemarks.first;
      eventlocationname = place.subAdministrativeArea ?? '';

    }
    notifyListeners();
    
    }

  CameraPosition get initialCameraPosition {
    return CameraPosition(
      target: LatLng(locationData.latitude ?? 37.43296265331129, locationData.longitude ?? -122.08832357078792),
      zoom: 17,
    );
  }

  
}
