import 'package:flutter/material.dart';

import 'package:here/views/components/position_card.dart';
import 'package:here/views/components/placemark_card.dart';

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
      child: StreamBuilder(
        stream: sl.get<LocationBloc>().location,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(!snapshot.hasData) return CircularProgressIndicator();
          else if(snapshot.hasData) {
            Location location = snapshot.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                PositionCard(position: location.position,),
                PlacemarkCard(placemark: location.placemark,),
              ],
            );
          }
         },
      ),
    );
  }
}