import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'package:here/service_locator.dart';
import 'package:here/models/location.dart';
import 'package:here/services/map_service.dart';
import 'package:here/controllers/location_manager.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  //TODO: Add another fingerprints for key when release the app


  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      sl.get<MapService>().onMapCreated(controller);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: null,
      stream: sl.get<LocationManager>().location,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(!snapshot.hasData) return CircularProgressIndicator();
        else if(snapshot.hasData) {
          Location location = snapshot.data;
          sl.get<MapService>().mapCurrentLocation(location);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SizedBox(
                  width: null,
                  height: 400,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    options: sl.get<MapService>().mapOptions,
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  @override
  void dispose() {
    sl.get<MapService>().dispose();
    super.dispose();
  }
}