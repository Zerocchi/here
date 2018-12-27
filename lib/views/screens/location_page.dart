import 'package:flutter/material.dart';

import 'package:here/service_locator.dart';
import 'package:here/models/location.dart';
import 'package:here/blocs/location_bloc.dart';

class LocationPage extends StatefulWidget {
  @override
  LocationPageState createState() {
    return new LocationPageState();
  }
}

class LocationPageState extends State<LocationPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: StreamBuilder(
          stream: sl.get<LocationBloc>().location,
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(!snapshot.hasData) return CircularProgressIndicator();
            else if(snapshot.hasData) {
              Location location = snapshot.data;
              return Text("Position: ${location.position}, Placemark: ${location.placemark.name}");
            }
           },
        ),
      ),
    );
  }

  @override
  void dispose() {
    sl.get<LocationBloc>().dispose();
    super.dispose();
  }
}