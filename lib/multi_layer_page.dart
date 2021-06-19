import 'package:flutter/material.dart';
import 'package:vector_map/vector_map.dart';

import 'example_page.dart';

class MultiLayerPage extends StatefulWidget {
  @override
  MultiLayerPageState createState() => MultiLayerPageState();
}

class MultiLayerPageState extends ExamplePageState {
  @override
  Future<DataSources> loadDataSources() async {
    MapDataSource polygons =
        await MapDataSource.geoJSON(geojson: polygonsGeoJSON);
    MapDataSource points = await MapDataSource.geoJSON(geojson: pointsGeoJSON);
    return DataSources(polygons: polygons, points: points);
  }

  @override
  Widget buildContent() {
    MapHighlightTheme highlightTheme = MapHighlightTheme(color: Colors.green);

    MapLayer polygonsLayer =
        MapLayer(dataSource: polygons, highlightTheme: highlightTheme);
    MapLayer pointsLayer = MapLayer(
        dataSource: points,
        theme: MapTheme(color: Colors.black),
        highlightTheme: highlightTheme);

    VectorMap map = VectorMap(layers: [polygonsLayer, pointsLayer]);
    return map;
  }
}
