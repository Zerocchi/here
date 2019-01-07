import 'package:flutter/material.dart';

import 'package:here/service_locator.dart';
import 'package:here/controllers/location_manager.dart';

class PoiPage extends StatefulWidget {
  @override
  PoiPageState createState() {
    return new PoiPageState();
  }
}

class PoiPageState extends State<PoiPage> {

  @override
  void initState() {
    sl.get<LocationManager>().isLessThanMeters(500);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}