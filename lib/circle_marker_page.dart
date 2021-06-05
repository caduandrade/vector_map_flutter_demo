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
    MapTheme hoverTheme = MapTheme(color: Colors.green);

    MapLayer polygonsLayer =
        MapLayer(dataSource: polygons, hoverTheme: hoverTheme);

    MapLayer pointsLayer = MapLayer(
        dataSource: points,
        theme: MapTheme(color: Colors.black),
        hoverTheme: hoverTheme);

    VectorMap map = VectorMap(layers: [polygonsLayer, pointsLayer]);
    return map;
  }

  Widget _fixed() {
    MapTheme hoverTheme = MapTheme(color: Colors.green);

    MapLayer polygonsLayer =
        MapLayer(dataSource: polygons, hoverTheme: hoverTheme);

    MapLayer pointsLayer = MapLayer(
        dataSource: points,
        theme: MapTheme(
            color: Colors.black,
            markerBuilder: CircleMakerBuilder.fixed(radius: 15)),
        hoverTheme: hoverTheme);

    VectorMap map = VectorMap(layers: [polygonsLayer, pointsLayer]);
    return map;
  }

  Widget _map() {
    MapTheme hoverTheme = MapTheme(color: Colors.green);

    MapLayer polygonsLayer =
        MapLayer(dataSource: polygons, hoverTheme: hoverTheme);

    MapLayer pointsLayer = MapLayer(
        dataSource: points,
        theme: MapTheme(
            color: Colors.black,
            markerBuilder: CircleMakerBuilder.map(
                key: 'AN', radiuses: {41: 25, 22: 20, 14: 10, 10: 10})),
        hoverTheme: hoverTheme);

    VectorMap map = VectorMap(layers: [polygonsLayer, pointsLayer]);
    return map;
  }

  Widget _property() {
    MapTheme hoverTheme = MapTheme(color: Colors.green);

    MapLayer polygonsLayer =
        MapLayer(dataSource: polygons, hoverTheme: hoverTheme);

    MapLayer pointsLayer = MapLayer(
        dataSource: points,
        theme: MapTheme(
            color: Colors.black,
            markerBuilder: CircleMakerBuilder.property(key: 'AN')),
        hoverTheme: hoverTheme);

    VectorMap map = VectorMap(layers: [polygonsLayer, pointsLayer]);
    return map;
  }

  Widget _proportion() {
    MapTheme hoverTheme = MapTheme(color: Colors.green);

    MapLayer polygonsLayer =
        MapLayer(dataSource: polygons, hoverTheme: hoverTheme);

    MapLayer pointsLayer = MapLayer(
        dataSource: points,
        theme: MapTheme(
            color: Colors.black,
            markerBuilder: CircleMakerBuilder.proportion(
                key: 'AN', minRadius: 4, maxRadius: 20)),
        hoverTheme: hoverTheme);

    VectorMap map = VectorMap(layers: [polygonsLayer, pointsLayer]);
    return map;
  }
}
