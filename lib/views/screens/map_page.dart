import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'package:here/service_locator.dart';
import 'package:here/models/location.dart';
import 'package:here/blocs/location_bloc.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  //TODO: Add another fingerprints for key when release the app

  GoogleMapController _mapController;

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  _mapInitialLocation() {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(51.5160895, -0.1294527),
          tilt: 30.0,
          zoom: 17.0,
        ),
      )
    );
  }

  _mapCurrentLocation(Location location) {
    if(_mapController != null) {
      sl.get<LocationBloc>().location.listen((Location location) {
        _mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(location.position.latitude, location.position.longitude),
              tilt: 30.0,
              zoom: 17.0,
            ),
          )
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: null,
      stream: sl.get<LocationBloc>().location,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(!snapshot.hasData) return CircularProgressIndicator();
        else if(snapshot.hasData) {
          Location location = snapshot.data;
          _mapCurrentLocation(snapshot.data);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SizedBox(
                  width: null,
                  height: null,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    options: GoogleMapOptions(
                      mapType: MapType.hybrid,
                      myLocationEnabled: true
                    ),
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
    _mapController.dispose();
    super.dispose();
  }
}