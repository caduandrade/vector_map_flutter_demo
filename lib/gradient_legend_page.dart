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
    return [MenuItem('Fill', _fill), MenuItem('Contour', _contour)];
  }

  Widget _fill() {
    MapLayer layer = MapLayer(
        dataSource: polygons,
        theme: MapGradientTheme(
            contourColor: Colors.white,
            labelVisibility: (feature) => true,
            key: 'Gts',
            min: 7500,
            max: 25000,
            colors: [Colors.blue, Colors.yellow, Colors.red]),
        highlightTheme: MapHighlightTheme(color: Colors.brown[900]));

    VectorMap map =
        VectorMap(layersPadding: EdgeInsets.fromLTRB(8, 8, 56, 8), layers: [
      layer
    ], addons: [
      GradientLegend(
          layer: layer, barBorder: Border.all(width: 1, color: Colors.black))
    ]);

    return map;
  }

  Widget _contour() {
    MapLayer layer = MapLayer(
        dataSource: polygons,
        theme: MapGradientTheme(
            contourColor: Colors.white,
            labelVisibility: (feature) => true,
            key: 'Gts',
            colors: [Colors.blue, Colors.yellow, Colors.red]),
        highlightTheme: MapHighlightTheme(contourColor: Colors.brown[900]));

    VectorMap map = VectorMap(
        layersPadding: EdgeInsets.fromLTRB(8, 8, 56, 8),
        layers: [layer],
        addons: [GradientLegend(layer: layer)]);

    return map;
  }
}
