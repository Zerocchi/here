import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:here/service_locator.dart';
import 'package:here/models/venue.dart';
import 'package:here/services/location_service.dart';
import 'package:here/services/venue_service.dart';
import 'package:here/controllers/venue_manager.dart';

class PoiBottomSheet extends StatefulWidget {
  @override
  _PoiBottomSheetState createState() => _PoiBottomSheetState();
}

class _PoiBottomSheetState extends State<PoiBottomSheet> {

  Position lastPosition;

  @override
  initState() {
    sl.get<LocationService>().getLastPosition().then((Position position) {
      sl.get<VenueManager>().getVenues(position);
    });
    super.initState();
  }

  Widget _venuesList(List<Venue> venues) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      AppBar(
        title: Text("Place of Interests"),
        backgroundColor: Colors.lightBlue,
        leading: Icon(Icons.location_city),
        actions: <Widget>[
          Image.asset("assets/images/4sq.png", height: 86, width: 164,),
        ],
      ),
      ListView.builder(
        scrollDirection: Axis.vertical,
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return WebviewScaffold(
              url: sl.get<VenueService>().venueUrl(venue),
              appBar: AppBar(
                title: Text(venue.name),
              ),
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: sl.get<VenueManager>().venues,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(!snapshot.hasData) return GradientProgressIndicator(gradient: Gradients.coldLinear);
        return _venuesList(snapshot.data);
      }
    );
  }
}