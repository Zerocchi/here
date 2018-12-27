import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';

import 'package:here/service_locator.dart';
import 'package:here/models/venue.dart';
import 'package:here/services/location_fetcher.dart';
import 'package:here/blocs/location_bloc.dart';
import 'package:here/blocs/venue_bloc.dart';

class PoiBottomSheet extends StatefulWidget {
  @override
  _PoiBottomSheetState createState() => _PoiBottomSheetState();
}

class _PoiBottomSheetState extends State<PoiBottomSheet> {

  Position lastPosition;

  @override
  initState() {
    sl.get<LocationFetcher>().getLastPosition().then((Position position) {
      sl.get<VenueBloc>().getVenues(position);
    });
    super.initState();
  }

  Widget _venuesList(List<Venue> venues) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      AppBar(
        title: Text("Place of Interests"),
        leading: Icon(Icons.location_city),
      ),
      ListView.builder(
        shrinkWrap: true,
        itemCount: venues.length,
        itemBuilder: (BuildContext context, int index) {
          return _venueListTile(venues[index]);
        },
      )
    ]);
  }

  Widget _venueListTile(Venue venue) {
    return ListTile(
      leading: FadeInImage.assetNetwork(
          placeholder: "assets/images/32.png",
          image: venue.categories.last.icon.full),
      title: Text(venue.name),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: sl.get<VenueBloc>().venues,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(!snapshot.hasData) return LinearProgressIndicator();
        return _venuesList(snapshot.data);
      }
    );
  }
}