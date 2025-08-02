import 'package:evently/providers/settings_provide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Maps extends StatelessWidget {
  const Maps({super.key});

  

  @override
  Widget build(BuildContext context) {
    SettingsProvide settingsProvider = Provider.of<SettingsProvide>(context);
    settingsProvider.getlocation();
    return Scaffold(
      body: GoogleMap(initialCameraPosition: settingsProvider.initialCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          settingsProvider.mapController = controller;
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
       
        mapType: MapType.normal,
      ),


    );
  }
}