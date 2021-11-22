import 'dart:convert';

import 'package:flutter/services.dart';

class GeoJsonAsset {
  static Future<String> polygons() {
    return rootBundle.loadString('assets/polygons.json');
  }

  static Future<String> points() {
    return rootBundle.loadString('assets/points.json');
  }

  static Future<String> brazilCounties() {
    return rootBundle.loadString('assets/brazil_counties.json');
  }

  static Future<String> brazilStates() {
    return rootBundle.loadString('assets/brazil_states.json');
  }

  static Future<String> world() {
    return rootBundle.loadString('assets/world.json');
  }

  static Future<String> worldMarkers() {
    return rootBundle.loadString('assets/world_markers.json');
  }

  static Future<String> brazilLines() {
    return rootBundle.loadString('assets/brazil_lines.json');
  }

  static Future<String> brazil() {
    return rootBundle.loadString('assets/brazil.json');
  }

  static void printPolygonProperties(String geojson) async {
    print('Name | Seq | Rnd | Gts');
    print('--- | --- | --- | ---');
    Map<String, dynamic> map = await json.decode(geojson);
    List features = map['features']!;
    for (Map<String, dynamic> feature in features) {
      Map<String, dynamic> properties = feature['properties'];
      String name = properties['Name'];
      int seq = properties['Seq'];
      String rnd = '';
      if (properties.containsKey('Rnd')) {
        rnd = properties['Rnd'];
        rnd = '"$rnd"';
      }
      int gts = properties['Gts'];
      print('"$name" | $seq | $rnd | $gts');
    }
  }

  static void printPointsProperties(String geojson) async {
    print('Name | AN');
    print('--- | ---');
    Map<String, dynamic> map = await json.decode(geojson);
    List features = map['features']!;
    for (Map<String, dynamic> feature in features) {
      Map<String, dynamic> properties = feature['properties'];
      String name = properties['Name'];
      int atomicNumber = properties['AN'];
      print('"$name" | $atomicNumber');
    }
  }
}
