import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vector_map/vector_map.dart';
import 'package:vector_map_demo/menu.dart';

import 'example_page.dart';

class GradientLegendPage extends StatefulWidget {
  @override
  GradientLegendPageState createState() => GradientLegendPageState();
}

class GradientLegendPageState extends ExamplePageState {
  @override
  Future<DataSources> loadDataSources() async {
    MapDataSource polygons = await MapDataSource.geoJSON(
        geojson: polygonsGeoJSON, keys: ['Gts'], labelKey: 'Gts');
    return DataSources(polygons: polygons);
  }

  @override
  List<MenuItem> buildMenuItems() {
    return [MenuItem('Legend', _legend)];
  }

  Widget _legend() {
    MapLayer layer = MapLayer(
        dataSource: polygons,
        hoverTheme: MapTheme(color: Colors.black),
        theme: MapGradientTheme(
            contourColor: Colors.white,
            labelVisibility: (feature) => true,
            key: 'Gts',
            colors: [Colors.blue, Colors.yellow, Colors.red]));

    VectorMap map =
        VectorMap(padding: EdgeInsets.fromLTRB(8, 8, 50, 8), layers: [
      layer
    ], addons: [
      GradientLegend(
          layer: layer, padding: EdgeInsets.all(5), margin: EdgeInsets.all(5))
    ]);

    return map;
  }
}
