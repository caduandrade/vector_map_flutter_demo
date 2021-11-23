import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';
import 'package:vector_map/vector_map.dart';

class LayerHoverOffExample extends Example {
  @override
  Widget buildMainWidget(BuildContext context) => MainWidget();
}

class MainWidget extends StatefulWidget {
  @override
  MainWidgetState createState() => MainWidgetState();
}

class MainWidgetState extends State<MainWidget> {
  late VectorMapController _controller;

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

    _controller = VectorMapController(layers: [layer1, layer2]);
  }

  @override
  Widget build(BuildContext context) {
    VectorMap map = VectorMap(controller: _controller);
    return map;
  }
}
