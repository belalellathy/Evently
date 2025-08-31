import 'package:evently/apptheme.dart';
import 'package:evently/providers/settings_provide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Eventlocation extends StatelessWidget {
  const Eventlocation({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsProvide settingsProvider = Provider.of<SettingsProvide>(context);
    settingsProvider.getlocation();
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onTap: (LatLng location){
                settingsProvider.changeeventlocation(location);
           
                Navigator.pop(context);
              },
              initialCameraPosition: settingsProvider.initialCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                settingsProvider.mapController = controller;
              },
             
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: settingsProvider.isDark ? Apptheme.primarydark : Apptheme.blue,
                    ),
            child: Text('Tap on Location to Select', style: TextStyle(color:Colors.white, fontSize: 18, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
          )
        ],
      ),


    );
  }
}