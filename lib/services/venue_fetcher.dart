import 'package:async/async.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import 'package:here/models/key.dart';
import 'package:here/models/venue.dart';
import 'package:here/services/key_loader.dart';

class VenueFetcher {
  static VenueFetcher _fetcher = VenueFetcher._internal();
  static const String BASE_URL = "https://api.foursquare.com/v2/venues/explore";

  String _clientId = "";
  String _clientSecret = "";
  String _limit = "7";

  VenueFetcher._internal();

  factory VenueFetcher() {
    if(_fetcher == null) return VenueFetcher();
    else return _fetcher;
  }

  void loadKeys() {
    KeyLoader(keyPath: "assets/keys/keys.json").load().then((Key key){
      _clientId = key.clientId;
      _clientSecret = key.clientSecret;
    });
  }

  String _dateParser(DateTime dateToParse) {
    var formatter = new DateFormat('yyyyMMdd');
    String formatted = formatter.format(dateToParse);
    return formatted;
  }

  String constructUrl(Position position) {


    var queryParameters = {
      "client_id": "$_clientId",
      "client_secret": "$_clientSecret",
      //"v": "${_dateParser(DateTime.now())}",
      "v": "${_dateParser(DateTime.now())}",
      "limit": "$_limit",
      "ll": "${position.latitude},${position.longitude}"
    };
    return Uri.https("api.foursquare.com", "/v2/venues/explore", queryParameters).toString();
  }

  Future<List<Venue>> getVenues(Position position) async {
    final AsyncMemoizer<List<Venue>> _memoizer = AsyncMemoizer<List<Venue>>();
    return _memoizer.runOnce(() async {
      List<Venue> venues = new List<Venue>();
      loadKeys();

      String url = constructUrl(position);
      print(url);
      var response = await http.get(url);
      List items = jsonDecode(response.body)["response"]["groups"][0]["items"];
      items.forEach((item) {
        venues.add(Venue.fromJson(item["venue"]));
      });
      return venues;
    });
  }
}