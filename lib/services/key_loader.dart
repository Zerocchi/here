import 'dart:async' show Future;
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

import 'package:here/models/key.dart';

class KeyLoader {
  final String keyPath;
  
  KeyLoader({this.keyPath});

  Future<Key> load() {
    return rootBundle.loadStructuredData<Key>(this.keyPath,
        (jsonStr) async {
      final keys = Key.fromJson(json.decode(jsonStr));
      return keys;
    });
  }
}