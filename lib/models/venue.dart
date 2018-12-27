// json["response"]["groups"][0]["items"][iterate]["venue"]

class Venue {
  String id;
  String name;
  Location location;
  List<Categories> categories;

  Venue(
      {this.id, this.name, this.location, this.categories});

  Venue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
  }
}

class Location {
  String address;
  String crossStreet;
  double lat;
  double lng;
  List<LabeledLatLngs> labeledLatLngs;
  int distance;
  String postalCode;
  String cc;
  String city;
  String state;
  String country;
  List<String> formattedAddress;

  Location(
      {this.address,
      this.crossStreet,
      this.lat,
      this.lng,
      this.labeledLatLngs,
      this.distance,
      this.postalCode,
      this.cc,
      this.city,
      this.state,
      this.country,
      this.formattedAddress});

  Location.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    crossStreet = json['crossStreet'];
    lat = json['lat'];
    lng = json['lng'];
    if (json['labeledLatLngs'] != null) {
      labeledLatLngs = new List<LabeledLatLngs>();
      json['labeledLatLngs'].forEach((v) {
        labeledLatLngs.add(new LabeledLatLngs.fromJson(v));
      });
    }
    distance = json['distance'];
    postalCode = json['postalCode'];
    cc = json['cc'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    formattedAddress = json['formattedAddress'].cast<String>();
  }
}

class LabeledLatLngs {
  String label;
  double lat;
  double lng;

  LabeledLatLngs({this.label, this.lat, this.lng});

  LabeledLatLngs.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    lat = json['lat'];
    lng = json['lng'];
  }
}

class Categories {
  String id;
  String name;
  String pluralName;
  String shortName;
  CatIcon icon;
  bool primary;

  Categories(
      {this.id,
      this.name,
      this.pluralName,
      this.shortName,
      this.icon,
      this.primary});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pluralName = json['pluralName'];
    shortName = json['shortName'];
    icon = json['icon'] != null ? new CatIcon.fromJson(json['icon']) : null;
    primary = json['primary'];
  }
}

class CatIcon {
  String prefix;
  String suffix;
  String _full;

  String get full {
    String iconSize = "32";
    _full = prefix + "bg_" + iconSize + suffix;
    return _full;
  }

  CatIcon({this.prefix, this.suffix});

  CatIcon.fromJson(Map<String, dynamic> json) {
    prefix = json['prefix'];
    suffix = json['suffix'];
  }
}