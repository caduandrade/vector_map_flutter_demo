import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';
import 'package:vector_map/vector_map.dart';
import 'package:vector_map_demo/geojson_asset.dart';

class MultiLayerExample extends Example {
  @override
  Widget buildMainWidget(BuildContext context) => MainWidget();
}

class MainWidget extends StatefulWidget {
  @override
  MainWidgetState createState() => MainWidgetState();
}

class MainWidgetState extends State<MainWidget> {
  VectorMapController _controller = VectorMapController();

  @override
  void initState() {
    super.initState();
    _loadGeoJson();
  }

  void _loadGeoJson() async {
    String polygonsGeoJson = await GeoJsonAsset.polygons();
    String pointsGeoJson = await GeoJsonAsset.points();

    MapHighlightTheme highlightTheme = MapHighlightTheme(color: Colors.green);

    MapDataSource polygons =
        await MapDataSource.geoJson(geoJson: polygonsGeoJson);
    MapLayer polygonLayer =
        MapLayer(dataSource: polygons, highlightTheme: highlightTheme);
    _controller.addLayer(polygonLayer);

    MapDataSource points = await MapDataSource.geoJson(geoJson: pointsGeoJson);
    MapLayer pointsLayer = MapLayer(
        dataSource: points,
        theme: MapTheme(color: Colors.black),
        highlightTheme: highlightTheme);
    _controller.addLayer(pointsLayer);
  }

  @override
  Widget build(BuildContext context) {
    VectorMap map = VectorMap(controller: _controller);
    return map;
  }
}
