import 'package:flutter/material.dart';
import 'package:vector_map/vector_map.dart';
import 'package:vector_map_demo/menu.dart';

import 'example_page.dart';

class CircleMarkerPage extends StatefulWidget {
  @override
  CircleMarkerPageState createState() => CircleMarkerPageState();
}

class CircleMarkerPageState extends ExamplePageState {
  @override
  Future<DataSources> loadDataSources() async {
    MapDataSource polygons =
        await MapDataSource.geoJSON(geojson: polygonsGeoJSON);
    MapDataSource points =
        await MapDataSource.geoJSON(geojson: pointsGeoJSON, keys: ['AN']);
    return DataSources(polygons: polygons, points: points);
  }

  @override
  List<MenuItem> buildMenuItems() {
    return [
      MenuItem('Default radius', _default),
      MenuItem('Fixed radius', _fixed),
      MenuItem('Map', _map),
      MenuItem('Property', _property),
      MenuItem('Proportion', _proportion)
    ];
  }

  Widget _default() {
    MapLayer polygonsLayer = MapLayer(dataSource: polygons);

    MapLayer pointsLayer =
        MapLayer(dataSource: points, theme: MapTheme(color: Colors.black));

    VectorMap map = VectorMap(layers: [polygonsLayer, pointsLayer]);
    return map;
  }

  Widget _fixed() {
    MapLayer polygonsLayer = MapLayer(dataSource: polygons);

    MapLayer pointsLayer = MapLayer(
        dataSource: points,
        theme: MapTheme(
            color: Colors.black,
            markerBuilder: CircleMakerBuilder.fixed(radius: 15)));

    VectorMap map = VectorMap(layers: [polygonsLayer, pointsLayer]);
    return map;
  }

  Widget _map() {
    MapLayer polygonsLayer = MapLayer(dataSource: polygons);

    MapLayer pointsLayer = MapLayer(
        dataSource: points,
        theme: MapTheme(
            color: Colors.black,
            markerBuilder: CircleMakerBuilder.map(
                key: 'AN', radiuses: {41: 25, 22: 20, 14: 10, 10: 10})));

    VectorMap map = VectorMap(layers: [polygonsLayer, pointsLayer]);
    return map;
  }

  Widget _property() {
    MapLayer polygonsLayer = MapLayer(dataSource: polygons);

    MapLayer pointsLayer = MapLayer(
        dataSource: points,
        theme: MapTheme(
            color: Colors.black,
            markerBuilder: CircleMakerBuilder.property(key: 'AN')));

    VectorMap map = VectorMap(layers: [polygonsLayer, pointsLayer]);
    return map;
  }

  Widget _proportion() {
    MapLayer polygonsLayer = MapLayer(dataSource: polygons);

    MapLayer pointsLayer = MapLayer(
        dataSource: points,
        theme: MapTheme(
            color: Colors.black,
            markerBuilder: CircleMakerBuilder.proportion(
                key: 'AN', minRadius: 4, maxRadius: 20)));

    VectorMap map = VectorMap(layers: [polygonsLayer, pointsLayer]);
    return map;
  }
}
