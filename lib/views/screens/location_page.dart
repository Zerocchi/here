import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:here/views/components/position_card.dart';
import 'package:here/views/components/placemark_card.dart';

import 'package:here/service_locator.dart';
import 'package:here/models/location.dart';
import 'package:here/controllers/location_manager.dart';
import 'package:here/services/map_service.dart';

class LocationPage extends StatefulWidget {
  @override
  LocationPageState createState() {
    return new LocationPageState();
  }
}

class LocationPageState extends State<LocationPage> {

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      sl.get<MapService>().onMapCreated(controller);
    });
  }

  Widget _mapView() {
    return StreamBuilder(
      initialData: null,
      stream: sl.get<LocationManager>().location,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(!snapshot.hasData) return CircularProgressIndicator();
        else if(snapshot.hasData) {
          Location location = snapshot.data;
          sl.get<MapService>().mapCurrentLocation(location);
          return Container(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              options: sl.get<MapService>().mapOptions,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Colors.indigo[800],
            Colors.indigo[700],
            Colors.indigo[600],
            Colors.indigo[400],
          ],
        ),
      ),
      child: StreamBuilder(
        stream: sl.get<LocationManager>().location,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(!snapshot.hasData) return CircularProgressIndicator();
          else if(snapshot.hasData) {
            Location location = snapshot.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new RotationTransition(
                  turns: new AlwaysStoppedAnimation(325 / 360),
                    child: Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0),),
                      child: SizedBox(
                        width: 200,
                        height: 250,
                        child: _mapView(),
                      ),
                    ),
                  ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      PositionCard(position: location.position,),
                      PlacemarkCard(placemark: location.placemark,),
                    ],
                  )
                ),
              ],
            );
          }
         },
      ),
    );
  }

  @override
  void dispose() {
    sl.get<MapService>().dispose();
    super.dispose();
  }
}