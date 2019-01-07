import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:here/models/location.dart';

abstract class MapService {
  GoogleMapController mapController;
  GoogleMapOptions mapOptions;

  void onMapCreated(GoogleMapController controller);
  void mapCurrentLocation(Location location);
  void dispose();
}

class MapServiceImpl implements MapService {
  @override
  GoogleMapController mapController;
  static final MapServiceImpl _singleton = MapServiceImpl._();

  MapServiceImpl._();

  factory MapServiceImpl() {
    return _singleton ?? MapServiceImpl();
  }

  GoogleMapOptions mapOptions = GoogleMapOptions(
                mapType: MapType.hybrid,
                myLocationEnabled: true,
                scrollGesturesEnabled: true,
                rotateGesturesEnabled: true,
                zoomGesturesEnabled: true,
              );

  @override
  void mapCurrentLocation(Location location) {
    if(mapController != null) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(location.position.latitude, location.position.longitude),
            tilt: 30.0,
            zoom: 17.0,
          ),
        )
      );
    }

  }

  @override
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void dispose() {
    mapController.dispose();
  }

}