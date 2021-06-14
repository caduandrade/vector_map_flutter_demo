import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vector_map/vector_map.dart';
import 'package:vector_map_demo/menu.dart';

import 'example_page.dart';

class GradientPage extends StatefulWidget {
  @override
  GradientPageState createState() => GradientPageState();
}

class GradientPageState extends ExamplePageState {
  @override
  Future<DataSources> loadDataSources() async {
    MapDataSource polygons = await MapDataSource.geoJSON(
        geojson: polygonsGeoJSON, keys: ['Seq'], labelKey: 'Seq');
    return DataSources(polygons: polygons);
  }

  @override
  List<MenuItem> buildMenuItems() {
    return [
      MenuItem('Auto min max', _autoMinMax),
      MenuItem('Min max', _minMax),
      MenuItem('Legend', _legend)
    ];
  }

  Widget _autoMinMax() {
    MapLayer layer = MapLayer(
        dataSource: polygons,
        theme: MapGradientTheme(
            contourColor: Colors.white,
            labelVisibility: (feature) => true,
            key: 'Seq',
            colors: [Colors.blue, Colors.yellow, Colors.red]));

    VectorMap map = VectorMap(layers: [layer]);

    return map;
  }

  Widget _minMax() {
    MapLayer layer = MapLayer(
        dataSource: polygons,
        theme: MapGradientTheme(
            contourColor: Colors.white,
            labelVisibility: (feature) => true,
            key: 'Seq',
            min: 3,
            max: 9,
            colors: [Colors.blue, Colors.yellow, Colors.red]));

    VectorMap map = VectorMap(layers: [layer]);

    return map;
  }

  Widget _legend() {
    MapLayer layer = MapLayer(
        dataSource: polygons,
        theme: MapGradientTheme(
            contourColor: Colors.white,
            labelVisibility: (feature) => true,
            key: 'Seq',
            colors: [Colors.blue, Colors.yellow, Colors.red]));

    VectorMap map =
        VectorMap(padding: EdgeInsets.fromLTRB(8, 8, 50, 8), layers: [
      layer
    ], addons: [
      AddonContainer.anchor(
          addon: GradientLegend(layer: layer), padding: EdgeInsets.all(5))
    ]);

    return map;
  }
}
