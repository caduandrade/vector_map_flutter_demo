import 'package:flutter/material.dart';
import 'package:vector_map/vector_map.dart';
import 'package:vector_map_demo/menu.dart';

import 'example_page.dart';

class HoverLayerPage extends StatefulWidget {
  @override
  HoverLayerPageState createState() => HoverLayerPageState();
}

class HoverLayerPageState extends ExamplePageState {
  late MapDataSource dataSource1;
  late MapDataSource dataSource2;

  @override
  Future<DataSources> loadDataSources() async {
    return DataSources();
  }

  @override
  void initState() {
    super.initState();

    MapDataSource dataSource1 = MapDataSource.geometries([
      MapPolygon.coordinates([2, 3, 4, 5, 6, 3, 4, 1, 2, 3])
    ]);
    MapDataSource dataSource2 = MapDataSource.geometries([
      MapPolygon.coordinates([0, 2, 2, 4, 4, 2, 2, 0, 0, 2]),
      MapPolygon.coordinates([4, 2, 6, 4, 8, 2, 6, 0, 4, 2])
    ]);

    this.dataSource1 = dataSource1;
    this.dataSource2 = dataSource2;
  }

  @override
  List<MenuItem> buildMenuItems() {
    return [
      MenuItem('Overlay on', _overlayOn),
      MenuItem('Overlay off', _overlayOff)
    ];
  }

  Widget _overlayOff() {
    MapHighlightTheme highlightTheme =
        MapHighlightTheme(color: Colors.black, contourColor: Colors.black);

    MapLayer layer1 = MapLayer(
        dataSource: dataSource1,
        theme: MapTheme(color: Colors.yellow, contourColor: Colors.black),
        highlightTheme: highlightTheme);
    MapLayer layer2 = MapLayer(
        dataSource: dataSource2,
        theme: MapTheme(color: Colors.green, contourColor: Colors.black),
        highlightTheme: highlightTheme);

    VectorMap map = VectorMap(layers: [layer1, layer2]);
    return map;
  }

  Widget _overlayOn() {
    MapLayer layer1 = MapLayer(
        dataSource: dataSource1,
        theme: MapTheme(color: Colors.yellow, contourColor: Colors.black),
        highlightTheme: MapHighlightTheme(
            color: Colors.black,
            contourColor: Colors.black,
            overlayContour: true));
    MapLayer layer2 = MapLayer(
        dataSource: dataSource2,
        theme: MapTheme(color: Colors.green, contourColor: Colors.black),
        highlightTheme:
            MapHighlightTheme(color: Colors.black, contourColor: Colors.black));

    VectorMap map = VectorMap(layers: [layer1, layer2]);
    return map;
  }
}
